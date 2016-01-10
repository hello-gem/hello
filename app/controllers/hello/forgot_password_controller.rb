module Hello
  class ForgotPasswordController < ApplicationController
    dont_kick :guest

    before_action { @sender = Hello.configuration.mailer_sender }

    # GET /hello/passwords/forgot
    def index
      @entity = @forgot_password = ForgotPasswordEntity.new
    end

    # POST /hello/passwords/forgot
    def forgot
      @entity = @forgot_password = ForgotPasswordEntity.new(params.require(:forgot_password))
      @user = @forgot_password.user

      if @forgot_password.reset
        success
      else
        failure
      end
    end
  end
end
