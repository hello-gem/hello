module Hello
  module Rails
    module Controller
      module ImpersonationConcern
        
        extend ActiveSupport::Concern

        module ClassMethods
        end

        included do
          helper_method :impersonated?
        end

        def impersonate(user)
          store_impersonator
          create_access_token_for(user, 60.minutes.from_now, 60.minutes.from_now)
        end

        def hello_back_to_myself
          if impersonated?
            string = hello_impersonator_token
            destroy_and_clear_current_access_token_from_session
            self.session_access_token = string
          end
        end

        def impersonated?
          hello_impersonator_token.present?
        end



        private

            def store_impersonator
              set_hello_impersonator_token(session_access_token)
            end

            def hello_impersonator_token
              session['hello_impersonator']
            end

            def set_hello_impersonator_token(v)
              session['hello_impersonator'] = v
            end


      end
    end
  end
end