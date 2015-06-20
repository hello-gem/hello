module Hello
  class PasswordController < ApplicationController

    kick :guest, :novice
    sudo_mode

    before_action do
      @user_entity = UpdateMyUserEntity.new(@user = current_user)
    end



    # GET /hello/password
    def edit
      respond_to do |format|
        format.html {  }
        format.json { render json: @user.to_hash_profile, status: :ok }
      end
    end

    # PATCH /hello/password
    def update
      @user.password = user_params[:password]
      # @user.password_confirmation = user_params[:password_confirmation] if user_params[:password_confirmation]

      if @user.save
        flash[:notice] = @user_entity.success_message
        respond_to do |format|
          format.html { redirect_to hello.password_path }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end



    private

    def user_params
      params.require(:user)
    end

  end
end
