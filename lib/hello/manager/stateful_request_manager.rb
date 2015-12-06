module Hello
  module Manager
    class StatefulRequestManager < RequestManager

      def initialize(*args)
        super(*args)
        @finder          = Finder.new(self)
        @session_wrapper = SessionWrapper.new(self)
      end

      delegate  :session_token,  :session_token=,
                :session_tokens, :session_tokens=,
                to: :@session_wrapper

      # read

      delegate :current_accesses, to: :@finder

      def current_access
        if session_token.presence
          @current_access ||= current_accesses.select { |a| a.token == session_token }.first
        else
          nil
        end
      end

      # write

      def sign_in!(*args)
        super(*args).tap do |access|
          self.session_token = access.token
          self.session_tokens << access.token
        end
      end

      # delete

      def sign_out!
        super
        self.session_tokens = ::Access.where(token: session_tokens).pluck(:token)
        self.session_token  = session_tokens.first
      end

    end
  end
end
