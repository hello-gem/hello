module Hello
  class SuperEmailForgotPasswordController < ApplicationController

    dont_kick :guest

    # GET /hello/forgot
    def index
      @entity = @forgot_password = ForgotPasswordEntity.new
    end

    # POST /hello/remember
    def remember
      @entity = @forgot_password = ForgotPasswordEntity.new(params.require(:forgot_password))
      @user = @forgot_password.user

      if @forgot_password.reset
        success
      else
        failure
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
