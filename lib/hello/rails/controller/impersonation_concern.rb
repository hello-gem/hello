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

        def hello_impersonate(user)
          session['impersonated'] = 1
          create_access_token_for(user, 60.minutes.from_now, 60.minutes.from_now)
        end

        def hello_back_to_myself
          if impersonated?
            destroy_and_clear_current_access_token_from_session
            self.session_access_token = session_access_tokens.first
          end
        end

        def impersonated?
          !!session['impersonated']
        end

      end
    end
  end
end