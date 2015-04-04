module Hello
  module Rails
    module Controller
      module AccessTokenConcern
      
      extend ActiveSupport::Concern

      module ClassMethods
        def restrict_access_to_sudo_mode
          before_action(:restrict_access_to_sudo_mode)
        end
      end

      #
      # AccessToken
      #

      included do
        helper_method :current_user, :hello_access_token, :sudo_mode?, :impersonated?
        before_action :hello_keep_alive, if: :hello_access_token
      end

      def current_user
        hello_user
      end

      def create_hello_access_token(user, expires_at=nil, sudo_expires_at=nil)
        expires_at ||= hello_default_session_expiration
        attrs = {
          user:               user,
          user_agent_string:  user_agent,
          expires_at:         expires_at,
          ip:                 request.remote_ip
        }
        attrs[:sudo_expires_at] = sudo_expires_at if sudo_expires_at
        s = AccessToken.create!(attrs)
        set_hello_access_token_token(s.access_token)
        session['locale'] = nil
        hello_ensure_thread_locale
        return s
      end

      def destroy_and_clear_hello_access_token
        destroy_hello_access_token
        clear_hello_access_token
      end

      def hello_user
        @hello_user ||= hello_access_token && hello_access_token.user
      end

      def hello_access_token
        @hello_access_token ||= get_hello_access_token
      end

      def hello_impersonate(user)
        store_impersonator
        create_hello_access_token(user, 60.minutes.from_now, 60.minutes.from_now)
      end

      def hello_back_to_myself
        return unless hello_impersonator_token
        destroy_hello_access_token
        set_hello_access_token_token(hello_impersonator_token)
      end

      # helper method
      def impersonated?
        hello_impersonator_token.present?
      end

      #
      # Sudo Mode
      #

      # helper method
      def sudo_mode?
        hello_access_token && hello_access_token.sudo_expires_at.future?
      end

      def restrict_access_to_sudo_mode
        if hello_access_token.nil? || hello_access_token.sudo_expires_at.past?
          render_hello_sudo_mode
        end
      end

          def render_hello_sudo_mode
            session[:hello_url] = url_for(params.merge only_path: true)
            render '/hello/sudo_mode/form'
          end

      private

          def access_token
            params['access_token'] || request.headers['HTTP_ACCESS_TOKEN'] || session['access_token'] || cookies['access_token']
          end

          def destroy_hello_access_token
            hello_access_token && hello_access_token.destroy
          end

          def set_hello_access_token_token(v)
            session['access_token'] = v
            clear_session_ivars
          end

          def clear_hello_access_token
            set_hello_access_token_token(nil)
            set_hello_impersonator_token(nil)
          end

          def clear_session_ivars
            @hello_user = @hello_access_token = nil
          end

          def store_impersonator
            set_hello_impersonator_token(access_token)
          end

          def hello_impersonator_token
            session['hello_impersonator']
          end

          def set_hello_impersonator_token(v)
            session['hello_impersonator'] = v
          end

          def get_hello_access_token
            return nil unless access_token
            
            s = AccessToken.find_by_access_token(access_token)
            return s if s && s.expires_at.future?
            
            s && s.destroy
            set_hello_access_token_token(nil)
            set_hello_impersonator_token(nil)
            nil
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
            is_near_expire = hello_access_token.expires_at < 20.minutes.from_now
            hello_access_token.update_attribute :expires_at, hello_default_session_expiration if is_near_expire
            expires_in = view_context.time_ago_in_words(hello_access_token.expires_at)
            logger.info "  #{'Hello Session'.bold.light_blue} expires in #{expires_in}"
          end

      end
    end
  end
end