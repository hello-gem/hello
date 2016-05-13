module Hello
  module RequestManager
    class Stateful < Abstract

      autoload :Finder, 'hello/request_manager/stateful/finder'
      autoload :SessionWrapper, 'hello/request_manager/stateful/session_wrapper'

      def initialize(*args)
        super(*args)
        @finder          = Finder.new(self)
        @session_wrapper = SessionWrapper.new(self)
      end

      delegate :session_token,  :session_token=,
               :session_tokens, :session_tokens=,
               :refresh_session_tokens,
               to: :@session_wrapper

      # read

      delegate :current_accesses, to: :@finder

      def current_access
        if session_token.presence
          @current_access ||= current_accesses.find { |a| a.token == session_token }
        end
      end

      # write

      def sign_in!(*args)
        super(*args).tap do |access|
          self.session_token = access.token
          session_tokens << access.token
        end
      end

      # delete

      def sign_out!(access = current_access)
        self.session_token = session_tokens.first if is_current_access?(access)

        super(access)

        refresh_session_tokens
      end
    end
  end
end
