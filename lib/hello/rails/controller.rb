module Hello
  module Rails
    module Controller
      
      extend ActiveSupport::Concern

      # module ClassMethods
      # end

      included do
        helper_method :current_user
      end

      def current_user
        hello_user
      end

      def create_hello_session
        s = Hello::Session.create!(identity: @identity, ua: user_agent)
        set_hello_session_id(s.id)
      end

      def clear_hello_session
        set_hello_session_id(nil)
      end

      def hello_user
        hellovars[:user] ||= hello_session && hello_session.user
      end

      # not used yet
      # def hello_identity
      #   hellovars[:identity] ||= hello_session && hello_session.identity
      # end

      def hello_session
        hellovars[:session] ||= hello_session_id && Hello::Session.find(hello_session_id)
      end

      private

          def set_hello_session_id(v)
            session[:hello_session_id]=v
            @hellovars = nil
          end

          def hello_session_id
            session[:hello_session_id]
          end

          def hellovars
            @hellovars ||= {}
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
