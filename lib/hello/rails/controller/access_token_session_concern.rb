module Hello
  module Rails
    module Controller
      module AccessTokenSessionConcern
        
        # extend ActiveSupport::Concern

        # module ClassMethods
        # end

        # included do
        # end

        def destroy_and_clear_current_access_token_from_session
          current_access_token && current_access_token.destroy
          self.session_access_token = nil
          set_hello_impersonator_token(nil)
        end

        def session_access_tokens
          request.session['access_tokens'] ||= []
        end

        def session_access_tokens=(v)
          request.session['access_tokens']=v
          _hello_clear_session_ivars
        end

        def session_access_token
          request.session['access_token'] ||= []
        end

        def session_access_token=(v)
          request.session['access_token']=v
          _hello_clear_session_ivars
        end

            def _hello_clear_session_ivars
              @current_user = @current_access_token = @current_access_tokens = nil
            end

      end
    end
  end
end