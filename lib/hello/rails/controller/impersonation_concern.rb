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
          create_hello_access_token(user, 60.minutes.from_now, 60.minutes.from_now)
        end

        def hello_back_to_myself
          if impersonated?
            destroy_hello_access_token
            set_hello_access_token_token(hello_impersonator_token)
          end
        end

        def impersonated?
          hello_impersonator_token.present?
        end



        private

            def store_impersonator
              set_hello_impersonator_token(access_token)
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