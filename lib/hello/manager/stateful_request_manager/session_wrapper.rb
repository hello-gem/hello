module Hello
  module Manager
    class StatefulRequestManager < RequestManager
      class SessionWrapper

        attr_reader :manager

        def initialize(manager)
          @manager = manager
        end

        def session_access_tokens
          session['access_tokens'] ||= []
        end

        def session_access_tokens=(v)
          session['access_tokens']=v
          manager.clear_cache
        end

        def session_access_token
          session['access_token']
        end

        def session_access_token=(v)
          session['access_token']=v
          manager.clear_cache
        end

        def session
          manager.request.session
        end

      end
    end
  end
end
