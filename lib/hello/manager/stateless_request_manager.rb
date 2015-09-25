module Hello
  module Manager
    class StatelessRequestManager < RequestManager
      
      def current_access_tokens
        []
      end

      def current_access_token
        @current_access_token ||= begin
          return nil unless string  = param || header
          return nil unless user_id = string.split('-').first
          return nil unless user    = User.find_by_id(user_id)
          return nil unless model   = user.access_tokens.find_by_access_token(string)
          return nil unless model.active_access_token_or_destroy

          model
        end
      end

      private

      def param
        request.parameters['access_token']
      end

      def header
        request.headers['HTTP_ACCESS_TOKEN']
      end
    end
  end
end
