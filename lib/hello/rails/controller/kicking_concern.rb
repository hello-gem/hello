module Hello
  module Rails
    module Controller
      module KickingConcern
        
        extend ActiveSupport::Concern

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
          roles.map(&:to_s).each do |role|
            should_kick = current_user_or_guest.role == role
            return kick_redirection if should_kick
          end
        end

        def dont_kick(*roles)
          should_not_kick = roles.map(&:to_s).include?(current_user_or_guest.role)
          return kick_redirection unless should_not_kick
        end



        private

            def kick_redirection
              case current_user_or_guest.role
              when 'guest'
                redirect_to_sign_in
              when 'novice'
                redirect_to_novice
              else
                redirect_to_root
              end
            end

            def current_user_or_guest
              current_user || User.mock_guest
            end

            def redirect_to_root
              respond_to do |format|
                format.html { redirect_to '/' }
                format.json do
                  data   = {"message"=>"Access Denied."}
                  status = :forbidden # 403
                  render json: data, status: status
                end
              end
            end

            def redirect_to_sign_in
              respond_to do |format|
                format.html do
                  session[:url] = url_for(params.merge only_path: true)
                  redirect_to hello.sign_in_path
                end
                format.json do
                  data   = {"message"=>"An active access token must be used to query information about the current user."}
                  status = :unauthorized # 401
                  render json: data, status: status
                end
              end
            end

            def redirect_to_novice
              respond_to do |format|
                format.html { redirect_to '/novice' }
                format.json do
                  data   = {"message"=>"Access Denied, visit /novice and complete your registration."}
                  status = :forbidden # 403
                  render json: data, status: status
                end
              end
            end

      end
    end
  end
end