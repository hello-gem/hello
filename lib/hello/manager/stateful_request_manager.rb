module Hello
  module Manager
    class StatefulRequestManager < RequestManager

      def initialize(*args)
        super(*args)
        @finder          = Finder.new(self)
        @session_wrapper = SessionWrapper.new(self)
      end

      delegate  :session_access_token,  :session_access_token=,
                :session_access_tokens, :session_access_tokens=,
                to: :@session_wrapper

      delegate :current_access_tokens, to: :@finder
      
      def current_access_token
        return nil if not session_access_token.presence
        @current_access_token ||= current_access_tokens.select { |at| at.access_token == session_access_token }.first
      end


      
      def sign_in!(*args)
        super(*args).tap do |model|
          self.session_access_token = model.access_token
          self.session_access_tokens << model.access_token
        end
      end

      def sign_out!
        super
        self.session_access_token = nil
        self.session_access_tokens = AccessToken.where(access_token: self.session_access_tokens).pluck(:access_token)
        self.request.session['impersonated'] = nil
      end

    end
  end
end
