require_dependency "hello/application_controller"

module Hello
module ClassicRegistration
  class ForgotPasswordController < ApplicationController

    restrict_if_authenticated

    # GET /hello/forgot
    def index
      @forgot_password = ForgotPasswordEntity.new
    end

    # POST /hello/remember
    def remember
      @forgot_password = ForgotPasswordEntity.new(params.require(:forgot_password))
      @user = @forgot_password.user

      control = ForgotPasswordControl.new(self, @forgot_password)

      if @forgot_password.reset
        control.success
      else
        control.failure
      end
      
      session[:forgot_login] = @forgot_password.login
    end

    # GET /hello/remembered
    def remembered
      @forgot_password = ForgotPasswordEntity.new
      @forgot_password.login = session[:forgot_login]
    end


  end
end
end
