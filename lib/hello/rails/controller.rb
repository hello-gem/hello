module Hello
  module Rails
    module Controller
      
      extend ActiveSupport::Concern

      module ClassMethods
        def restrict_access_to_sudo_mode
          before_action(:restrict_access_to_sudo_mode)
        end
      end



      #
      # Session
      #

      included do
        helper_method :current_user, :hello_credential, :hello_session, :sudo_mode?, :impersonated?
        before_action :hello_keep_alive, if: :hello_session
      end

      def current_user
        hello_user
      end

      def create_hello_session(keep_me=false)
        expires_at = keep_me ? 30.days.from_now : 30.minutes.from_now
        s = Session.create!(credential: @credential, ua: user_agent, expires_at: expires_at)
        set_hello_session_token(s.token)
      end

      def clear_hello_session
        destroy_hello_session
        session.clear
        @hello_user = @hello_credential = @hello_session = nil
      end

      def hello_user
        @hello_user ||= hello_session && hello_session.user
      end

      def hello_credential
        @hello_credential ||= hello_session && hello_session.credential
      end

      def hello_session
        @hello_session ||= get_hello_session
      end

      def hello_impersonate(credential)
        store_impersonator
        @credential = credential
        create_hello_session(true)
      end

      def hello_back_to_myself
        destroy_hello_session
        set_hello_session_token(hello_impersonator_token)
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
        hello_session && hello_session.sudo_expires_at.future?
      end

      def restrict_access_to_sudo_mode
        if hello_session.nil? || hello_session.sudo_expires_at.past?
          render_hello_sudo_mode
        end
      end

          def render_hello_sudo_mode
            session[:hello_url] = url_for(params.merge only_path: true)
            render '/hello/sudo_mode/form'
          end

      private

          def destroy_hello_session
            hello_session && hello_session.destroy
          end

          def set_hello_session_token(v)
            # clear_hello_session
            session[:hello_session_token]=v
            @hellovars = nil
          end

          def hello_session_token
            session[:hello_session_token]
          end

          def store_impersonator
            session[:hello_impersonator] = hello_session_token
          end

          def hello_impersonator_token
            session[:hello_impersonator]
          end

          def get_hello_session
            return nil unless hello_session_token
            
            s = Session.where(token: hello_session_token).first
            return s if s && s.expires_at.future?
            
            s && s.destroy
            session.clear
            nil
          end

          # helper

          def user_agent
            request.user_agent || "blank_user_agent"
          end

          # filters

          def hello_keep_alive
            is_near_expire = hello_session.expires_at < 20.minutes.from_now
            hello_session.update_attribute :expires_at, 30.minutes.from_now if is_near_expire
            expires_in = view_context.time_ago_in_words(hello_session.expires_at)
            logger.info "  #{'Hello Session'.bold.light_blue} expires in #{expires_in}"
          end

    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Hello::Rails::Controller
  end
end
