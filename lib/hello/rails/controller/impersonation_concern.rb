module Hello
  module Rails
    module Controller
      module ImpersonationConcern
        
        extend ActiveSupport::Concern

        module ClassMethods
        end

        # OBSERVATION: this capability does not cover stateless requests

        included do
          helper_method :impersonated?
        end

        def hello_impersonate(user)
          session['impersonated'] = 1
          sign_in!(user, 60.minutes.from_now, 60.minutes.from_now)
        end

        def hello_back_to_myself
          if impersonated?
            sign_out!
            # sign in with next in line
            self.session_token = session_tokens.first
          end
        end

        def impersonated?
          # check StatefulRequestManager for a reference to session['impersonated']
          !!session['impersonated']
        end

      end
    end
  end
end