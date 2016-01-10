module Hello
  module Railsy
    module Controller
      module KickingConcern
        extend ActiveSupport::Concern

        # OBSERVATION: Kicking cares about the request format, not so much about state

        module ClassMethods
          def kick(*args)
            options, roles = _restrict_split(args)
            before_action(options) { kick(*roles) }
          end

          def dont_kick(*args)
            options, roles = _restrict_split(args)
            before_action(options) { dont_kick(*roles) }
          end

          def dont_kick_people
            # :)
          end

          def _restrict_split(args)
            options = args.pop if args.last.is_a? Hash
            [(options || {}), args]
          end
        end

        def kick(*roles)
          should_kick = roles.map { |r| current_user_or_guest.role_is? r }.inject(:|)
          return kick_redirection if should_kick
        end

        def dont_kick(*roles)
          should_not_kick = roles.map { |r| current_user_or_guest.role_is? r }.inject(:|)
          return kick_redirection unless should_not_kick
        end

        private

        def kick_redirection
          u = current_user_or_guest

          return redirect_to_sign_in if u.guest?
          return redirect_to_onboarding if u.onboarding?
          redirect_to_root
        end

        def current_user_or_guest
          current_user || ::User.new(role: 'guest')
        end

        def redirect_to_root
          respond_to do |format|
            format.html { redirect_to '/' }
            format.json do
              data   = { 'message' => 'Access Denied.' }
              status = :forbidden # 403
              render json: data, status: status
            end
          end
        end

        def redirect_to_sign_in
          respond_to do |format|
            format.html do
              hello_keep_current_url_on_session!
              redirect_to hello.sign_in_path
            end
            format.json do
              data   = { 'message' => 'An active access token must be used to query information about the current user.' }
              status = :unauthorized # 401
              render json: data, status: status
            end
          end
        end

        def redirect_to_onboarding
          respond_to do |format|
            format.html { redirect_to '/onboarding' }
            format.json do
              data   = { 'message' => 'Access Denied, visit /onboarding and complete your registration.' }
              status = :forbidden # 403
              render json: data, status: status
            end
          end
        end
      end
    end
  end
end
