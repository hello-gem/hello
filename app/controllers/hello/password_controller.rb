module Hello
  class PasswordController < ApplicationController

    kick :guest, :onboarding
    sudo_mode

    before_action do
      @password_credential = current_user.password_credential || raise(ActiveRecord::NotFound)
      @entity = UpdateMyUserEntity.new(@password_credential)
    end



    # GET /hello/password
    def edit
      respond_to do |format|
        format.html {  }
        format.json { head :no_content }
      end
    end

    # PATCH /hello/password
    def update
      @password_credential.password = password_credential_params[:password]
      # @password_credential.password_confirmation = password_credential_params[:password_confirmation] if password_credential_params[:password_confirmation]

      if @password_credential.save
        flash[:notice] = @entity.success_message
        respond_to do |format|
          format.html { redirect_to hello.password_path }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.json { render json: @password_credential.errors, status: :unprocessable_entity }
        end
      end
    end



    private

    def password_credential_params
      params.require(:password_credential)
    end

  end
end
