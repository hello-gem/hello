module Hello
  module Rails
    module Controller
      module ActiveSessionConcern
      
      extend ActiveSupport::Concern

      module ClassMethods
        def restrict_access_to_sudo_mode
          before_action(:restrict_access_to_sudo_mode)
        end
      end

      #
      # ActiveSession
      #

      included do
        helper_method :current_user, :hello_credential, :hello_active_session, :sudo_mode?, :impersonated?
        before_action :hello_keep_alive, if: :hello_active_session
      end

      def current_user
        hello_user
      end

      def create_hello_active_session(expires_at=nil)
        expires_at ||= hello_default_session_expiration
        s = ActiveSession.create!(credential: @credential, user_agent_string: user_agent, expires_at: expires_at)
        set_hello_active_session_token(s.access_token)
        session['locale'] = nil
        set_locale
        return s
      end

      def clear_hello_active_session
        destroy_hello_active_session
        set_hello_active_session_token(nil)
        @hello_user = @hello_credential = @hello_active_session = nil
      end

      def hello_user
        @hello_user ||= hello_active_session && hello_active_session.user
      end

      def hello_credential
        @hello_credential ||= hello_active_session && hello_active_session.credential
      end

      def hello_active_session
        @hello_active_session ||= get_hello_active_session
      end

      def hello_impersonate(credential)
        store_impersonator
        @credential = credential
        create_hello_active_session
      end

      def hello_back_to_myself
        destroy_hello_active_session
        set_hello_active_session_token(hello_impersonator_token)
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
        hello_active_session && hello_active_session.sudo_expires_at.future?
      end

      def restrict_access_to_sudo_mode
        if hello_active_session.nil? || hello_active_session.sudo_expires_at.past?
          render_hello_sudo_mode
        end
      end

          def render_hello_sudo_mode
            session[:hello_url] = url_for(params.merge only_path: true)
            render '/hello/sudo_mode/form'
          end

      private

          def access_token
            params['access_token'] || request.headers['access_token'] || session['access_token'] || cookies['access_token']
          end

          def destroy_hello_active_session
            hello_active_session && hello_active_session.destroy
          end

          def set_hello_active_session_token(v)
            session['access_token'] = v
            @hellovars = nil
          end

          def store_impersonator
            session[:hello_impersonator] = access_token
          end

          def hello_impersonator_token
            session[:hello_impersonator]
          end

          def get_hello_active_session
            return nil unless access_token
            
            s = ActiveSession.find_by_access_token(access_token)
            return s if s && s.expires_at.future?
            
            s && s.destroy
            set_hello_active_session_token(nil)
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
            is_near_expire = hello_active_session.expires_at < 20.minutes.from_now
            hello_active_session.update_attribute :expires_at, hello_default_session_expiration if is_near_expire
            expires_in = view_context.time_ago_in_words(hello_active_session.expires_at)
            logger.info "  #{'Hello Session'.bold.light_blue} expires in #{expires_in}"
          end

      end
    end
  end
end