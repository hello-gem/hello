module Hello
  module Rails
    module Controller
      module AccessTokenConcern
        
        extend ActiveSupport::Concern

        module ClassMethods
        end

        included do
          helper_method :current_access_tokens, :current_access_token, :is_current_access_token?
        end

        def is_current_access_token?(access_token)
          current_access_token == access_token
        end

        def current_access_tokens
          @current_access_tokens ||= if is_request_stateless?
            []
          else
            get_stateful_current_access_tokens
          end
        end

        def current_access_token
          @current_access_token ||= if is_request_stateless?
            get_stateless_current_access_token
          else
            get_stateful_current_access_token
          end
        end

        private

        def get_stateful_current_access_tokens
          Hello::AccessTokenLister.new(self).models
        end

        def get_stateless_current_access_token
          return nil unless string = params['access_token'] || request.headers['HTTP_ACCESS_TOKEN']
          return nil unless model  = AccessToken.find_by_access_token(string)
          return nil unless model.active_access_token_or_destroy
          model
        end

        def get_stateful_current_access_token
          return nil if session_access_token.nil?
          current_access_tokens_find_by_string(session_access_token)
        end

        def current_access_tokens_find_by_string(string)
          current_access_tokens
            .select { |at| at.access_token == string }
            .first
        end

        def current_access_tokens_find_by_id(string)
          current_access_tokens
            .select { |at| at.id.to_s == string }
            .first
        end

        def is_request_stateless?
          !is_request_stateful?
        end

        def is_request_stateful?
          has_api_on_url = request.host.starts_with?("api.") || request.fullpath.starts_with?("/api/")
          !has_api_on_url
        end

        
      end
    end
  end
end