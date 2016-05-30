module Hello
  module Management
    # you really should be overriding concerns instead of this file
    class ForgotPasswordController < ApplicationController
      include Hello::Concerns::Management::ForgotPassword

      dont_kick :guest

      before_action { @sender = Hello.configuration.mailer_sender }

      # GET /hello/passwords/forgot
      def index
        @forgot_password = Business::Management::ForgotPassword.new
        render 'hello/management/password_credentials/forgot'
      end

      # POST /hello/passwords/forgot
      def forgot
        @forgot_password = Business::Management::ForgotPassword.new(params.require(:forgot_password))
        @user = @forgot_password.user

        if @forgot_password.reset
          on_success
        else
          on_failure
        end
      end

      private

      def render_success
        render 'hello/management/password_credentials/forgot_success'
      end

      def render_form
        render 'hello/management/password_credentials/forgot'
      end

    end
  end
end
