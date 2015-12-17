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
        @current_access = @current_accesses = nil
      end



      def signed_in?
        !!current_user
      end

      def is_current_user?(user)
        current_user == user
      end

      def is_current_access?(access)
        current_access == access
      end

      def current_user
        current_access && current_access.user
      end

      def current_accesses
        raise NotImplementedError
      end

      def current_access
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
        ::Access.create!(attrs)
      end

      def sign_out!(access=nil)
        access ||= current_access
        access and access.destroy!
        clear_cache
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
