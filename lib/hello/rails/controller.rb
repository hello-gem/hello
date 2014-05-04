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
        helper_method :current_user, :hello_identity
      end

      def current_user
        hello_user
      end

      def create_hello_session
        s = Session.create!(identity: @identity, ua: user_agent)
        set_hello_session_id(s.id)
      end

      def clear_hello_session
        destroy_hello_session
        session.clear
        @hello_user = @hello_identity = @hello_session = nil
      end

      def hello_user
        @hello_user ||= hello_session && hello_session.user
      end

      def hello_identity
        @hello_identity ||= hello_session && hello_session.identity
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
            # actual
            # Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:27.0) Gecko/20100101 Firefox/27.0
            # Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/537.75.14
            # Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36

            # expect
            # Mac OS X - Firefox
            # Mac OS X - Chrome
            # Mac OS X - Safari
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
