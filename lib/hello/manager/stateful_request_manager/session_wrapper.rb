module Hello
  module Manager
    class StatefulRequestManager < RequestManager
      class SessionWrapper
        def initialize(manager)
          @manager = manager
        end

        def session_tokens
          session['tokens'] ||= []
        end

        def session_tokens=(v)
          session['tokens'] = v
          @manager.clear_cache
        end

        def session_token
          session['token']
        end

        def session_token=(v)
          session['token'] = v
          @manager.clear_cache
        end

        def refresh_session_tokens
          self.session_tokens = ::Access.where(token: session_tokens).pluck(:token)
        end

        def session
          @manager.request.session
        end
      end
    end
  end
end
