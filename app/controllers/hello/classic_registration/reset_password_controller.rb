require_dependency "hello/application_controller"

module Hello
  class ClassicRegistration::ResetPasswordController < ApplicationController

    # restrict_if_authenticated, except: [:done]

    # GET /hello/password/reset/:token
    def reset_token
      destroy_and_clear_hello_access_token
      @reset_password = ResetPasswordEntity.new(params[:token])

      if @reset_password.user
        session[:hello_reset_token] = params[:token]
        redirect_to password_reset_path
      else
        flash[:alert] = @reset_password.alert_message
        redirect_to password_forgot_path
      end
    end

    # GET /hello/password/reset
    def index
      fetch_registration_reset_ivar
    end

    # POST /hello/password/reset
    def save
      fetch_registration_reset_ivar
      control = ResetPasswordControl.new(self, @reset_password)

      new_password = params.require(:reset_password)[:password]
      if @reset_password.update_password(new_password)
        @user.invalidate_password_token
        flash[:notice] = @reset_password.success_message
        control.success
      else
        control.failure
      end
    end

    # GET /hello/password/reset/done
    def done
    end





    private

        def fetch_registration_reset_ivar
          return redirect_to forgot_path unless session[:hello_reset_token]
          @reset_password = ResetPasswordEntity.new(session[:hello_reset_token])
          @user = @reset_password.user
        end


  end
end
