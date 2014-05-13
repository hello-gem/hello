module Hello
  module Rails
    module Controller
      
      extend ActiveSupport::Concern

      # module ClassMethods
      # end



      def deliver_password_forgot
        instance_eval(&Hello.config.forgot.deliver_password_forgot)
      end

      #
      # Session
      #

      included do
        helper_method :current_user, :hello_credential, :hello_session
        before_action :hello_keep_alive, if: :hello_session
      end

      def current_user
        hello_user
      end

      def create_hello_session(keep_me=false)
        expires_at = keep_me ? 30.days.from_now : 30.minutes.from_now
        s = Session.create!(credential: @credential, ua: user_agent, expires_at: expires_at)
        set_hello_session_id(s.id)
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

      private

          def destroy_hello_session
            hello_session && hello_session.destroy
          end

          def set_hello_session_id(v)
            clear_hello_session
            session[:hello_session_id]=v
            @hellovars = nil
          end

          def hello_session_id
            session[:hello_session_id]
          end

          def get_hello_session
            return nil unless hello_session_id
            s = Session.find(hello_session_id)
            return s if s.expires_at.future?
            s.destroy
            session.clear
            nil
          rescue ActiveRecord::RecordNotFound
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
