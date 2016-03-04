module Hello
  class ResetPasswordController < ApplicationController
    include Hello::Concerns::ResetPasswordOnSuccess
    include Hello::Concerns::ResetPasswordOnFailure

    sign_out!

    before_action do
      # a helping ivar
      @current_url = request.fullpath
      # find
      @user = ::User.find(params[:user_id])
      @password_credential = @user.password_credentials.find(params[:id])
      unless @password_credential.verifying_token_is?(params[:token])
        fail ActiveRecord::RecordNotFound
      end
      # entity
      @reset_password = ResetPasswordEntity.new(@password_credential)
    end

    # GET /passwords/:id/reset/:user_id/:token
    def index
      render_reset_form
    end

    # POST /passwords/:id/reset/:user_id/:token
    def update
      new_password = params.require(:reset_password)[:password]
      if @reset_password.update_password(new_password)
        flash[:notice] = @reset_password.success_message
        on_success
      else
        on_failure
      end
    end

    rescue_from ActiveRecord::RecordNotFound do
      flash[:alert] = ResetPasswordEntity.new(nil).alert_message
      redirect_to forgot_passwords_path
    end

    private

    def render_reset_form
      render 'hello/management/password_credentials/reset'
    end
  end
end
