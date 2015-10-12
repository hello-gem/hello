module Hello
  class PasswordsController < ApplicationController


    kick :guest, :onboarding
    sudo_mode

    before_action do
      @password_credential = current_user.password_credential || raise(ActiveRecord::NotFound)
      @entity = UpdateCurrentUserEntity.new(@password_credential)
    end

    # GET /hello/passwords
    def index
      respond_to do |format|
        format.html { redirect_to password_path(@password_credential.id) }
        format.json { head :no_content }
      end
    end



    # GET /hello/passwords/1
    def show
      respond_to do |format|
        format.html {  }
        format.json { head :no_content }
      end
    end

    # PATCH /hello/passwords/1
    def update
      @password_credential.password = password_credential_params[:password]
      # @password_credential.password_confirmation = password_credential_params[:password_confirmation] if password_credential_params[:password_confirmation]

      if @password_credential.save
        flash[:notice] = @entity.success_message
        respond_to do |format|
          format.html { redirect_to hello.password_path(@password_credential.id) }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { render :show }
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
