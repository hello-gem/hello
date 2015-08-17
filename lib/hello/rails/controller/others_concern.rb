module Hello
  module Rails
    module Controller
      module OthersConcern
        
        extend ActiveSupport::Concern

        module ClassMethods
        end

        included do
          before_action :hello_keep_alive, if: :current_access_token
        end



        # helper

        def user_agent
          request.user_agent || "blank_user_agent"
        end

        def hello_default_session_expiration
          30.minutes.from_now
        end

        # filters
        
        def hello_keep_alive
          periodically_delete_expired_access_tokens_from_database

          is_near_expire = current_access_token.expires_at < 20.minutes.from_now
          current_access_token.update_attribute :expires_at, hello_default_session_expiration if is_near_expire
          expires_in = view_context.time_ago_in_words(current_access_token.expires_at)
          logger.info "  #{'Hello Session'.bold.light_blue} expires in #{expires_in}"
        end

            # TODO: find a better way
            def periodically_delete_expired_access_tokens_from_database
              AccessToken.cached_delete_all_expired
            end

      end
    end
  end
end