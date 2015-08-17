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

        def current_access_tokens
          @current_access_tokens ||= Hello::AccessTokenLister.new(self).models
        end

        def is_current_access_token?(access_token)
          current_access_token == access_token
        end

        def current_access_token
          return nil if session_access_token.nil?
          @current_access_token ||= current_access_tokens_find_by_string(session_access_token)
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

      end
    end
  end
end