module Hello
  class ForgotPasswordController < ApplicationController
    include Hello::Concerns::ForgotPasswordOnSuccess
    include Hello::Concerns::ForgotPasswordOnFailure

    dont_kick :guest

    before_action { @sender = Hello.configuration.mailer_sender }

    # GET /hello/passwords/forgot
    def index
      @entity = @forgot_password = ForgotPasswordEntity.new
      render 'hello/management/password_credentials/forgot'
    end

    # POST /hello/passwords/forgot
    def forgot
      @entity = @forgot_password = ForgotPasswordEntity.new(params.require(:forgot_password))
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
