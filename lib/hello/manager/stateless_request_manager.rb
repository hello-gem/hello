module Hello
  module Manager
    class StatelessRequestManager < RequestManager
      
      def current_accesses
        []
      end

      def current_access
        @current_access ||= begin
          return nil unless string  = param || header
          return nil unless user_id = string.split('-').first
          return nil unless user    = User.find_by_id(user_id)
          return nil unless model   = user.accesses.find_by_token(string)
          return nil unless model.active_token_or_destroy

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
