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
      end

      def current_user
        hello_user
      end

      def create_hello_session
        s = Session.create!(credential: @credential, ua: user_agent)
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
            return Session.find(hello_session_id)
            rescue ActiveRecord::RecordNotFound
              session.clear
              nil
          end

          # helper

          def user_agent
            request.user_agent || "blank_user_agent"
          end

    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Hello::Rails::Controller
  end
end
