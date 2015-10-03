module Hello
  class ResetPasswordController < ApplicationController

    sign_out!

    before_action do
      # a helping ivar
      @current_url = request.fullpath
      # find
      @user = User.find(params[:user_id])
      @password_credential = @user.password_credentials.find(params[:id])
      if not @password_credential.verifying_token_is?(params[:token])
        raise ActiveRecord::RecordNotFound
      end
      # entity
      @reset_password = ResetPasswordEntity.new(@password_credential)
    end

    # # GET /passwords/:id/reset/:user_id/:token
    def index
    end

    # POST /passwords/:id/reset/:user_id/:token
    def update
      new_password = params.require(:reset_password)[:password]
      if @reset_password.update_password(new_password)
        flash[:notice] = @reset_password.success_message
        success
      else
        failure
      end
    end

    rescue_from ActiveRecord::RecordNotFound do
      flash[:alert] = ResetPasswordEntity.new(nil).alert_message
      redirect_to forgot_passwords_path
    end

  end
end
