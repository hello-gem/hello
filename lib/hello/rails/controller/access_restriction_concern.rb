module Hello
  module Rails
    module Controller
      module AccessRestrictionConcern
        
        extend ActiveSupport::Concern

        module ClassMethods

          #
          # authentication
          #
          def restrict_if_authenticated(options={})
            before_action(options) { restrict_if_authenticated }
          end

          def restrict_unless_authenticated(options={})
            before_action(options) { restrict_unless_authenticated }
          end

          #
          # authorization
          #
          def restrict_if_role_is(*args)
            options, args = _restrict_split(args)
            before_action(options) { restrict_if_role_is(*args) }
          end

          def restrict_unless_role_is(*args)
            options, args = _restrict_split(args)
            before_action(options) { restrict_unless_role_is(*args) }
          end

          #
          # shortcuts
          #
          def restrict_to_users(options={})
            before_action(options) { restrict_to_users }
          end

              def _restrict_split(args)
                # puts "args: #{args}"
                options = args.pop if args.last.is_a? Hash
                # puts "roles: #{args}"
                # puts "options: #{options}"
                [(options || {}), args]
              end

        end

        included do

          rescue_from Hello::AccessDenied do |exception|
            data = {
              exception: {
                class:          exception.class.name,
                message:        exception.message,
                # backtrace:   exception.backtrace
              }
            }

            # puts "denied #{exception.class}".on_red

            # headers["WWW-Authenticate"] = exception.message

            respond_to do |format|
              format.html do
                flash[:alert] = exception.alert_message
                session[:url] = request.fullpath
                #redirect_to _denied_pages_for[exception.role]
                redirect_to hello.homepage_path
              end
              format.json { render json: data, status: :bad_request } # 400
            end
          end





        end



        #
        # authentication
        #
        def restrict_unless_authenticated
          raise Hello::NotAuthenticated unless current_user
        end

        def restrict_if_authenticated
          raise Hello::Authenticated if current_user
        end

        #
        # authorization
        #
        def restrict_if_role_is(*denied_roles)
          restrict_unless_authenticated
          # puts "#{controller_name}##{action_name} as a #{Array(role).to_s.yellow}, but required: #{required_roles}"
          raise Hello::NotAuthorizedCannotBe.new(role) if denied_roles.include? role
        end

        def restrict_unless_role_is(*required_roles)
          restrict_unless_authenticated
          # puts "#{controller_name}##{action_name} as a #{Array(role).to_s.yellow}, but required: #{required_roles}"
          raise Hello::NotAuthorizedMustBe.new(_min_required_role(required_roles)) unless required_roles.include? role
        end

        #
        # shortcuts
        #
        def restrict_to_users
          restrict_if_role_is :novice
        end


        private

            def role
              # @role ||= (current_user && current_user.role || 'guest').to_sym
              @role ||= current_user.role.to_sym
            end

            def _denied_pages_for
              {
                guest:  hello.sign_in_path,
                novice: '/novice',
                user:   hello.user_path,
                admin:  hello.admin_path,
              }
            end

            def _roles
              [:guest, :novice, :user, :admin]
            end

            def _min_required_role(roles)
              (_roles & roles).first
            end

      end
    end
  end
end