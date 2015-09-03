module Hello
  module Manager
    class RequestManager

      class << self
        def create(request)
          RequestManagerFactory.new(request).create
        end
      end

      def initialize(request)
        @request = request
      end

      def clear_cache
        @current_access_token = @current_access_tokens = nil
      end



      def signed_in?
        !!current_user
      end

      def is_current_user?(user)
        current_user == user
      end

      def is_current_access_token?(access_token)
        current_access_token == access_token
      end

      def current_user
        current_access_token && current_access_token.user
      end

      def current_access_tokens
        raise NotImplementedError
      end

      def current_access_token
        raise NotImplementedError
      end



      def sign_in!(user, expires_at=nil, sudo_expires_at=nil)
        expires_at ||= 30.minutes.from_now

        attrs = {
          user:               user,
          user_agent_string:  user_agent,
          expires_at:         expires_at,
          ip:                 remote_ip
        }
        attrs[:sudo_expires_at] = sudo_expires_at if sudo_expires_at
        AccessToken.create!(attrs)
      end

      def sign_out!
        current_access_token && current_access_token.destroy!
      end

      # protected

          def user_agent
            request.user_agent || "blank_user_agent"
          end

          def remote_ip
            request.remote_ip
          end

          def request
            @request
          end

          def env
            request.env
          end

    end
  end
end
