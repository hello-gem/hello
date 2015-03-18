require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class UserController < ApplicationController

    restrict_to_users

    before_action do
      @user        = hello_user
      @user_entity = UpdateMyUserEntity.new(hello_user)
    end

    # GET /hello/user
    def edit
      respond_to do |format|
        format.html {  }
        format.json { render json: @user.to_hash_profile, status: :ok }
      end
    end

    # PATCH /hello/user
    def update
      control = UserControl.new(self, @user)
      if @user_entity.update(user_params)
        flash[:notice] = @user_entity.success_message
        control.success
      else
        control.failure
      end
    end

    # GET /hello/user_password
    def edit_password
      respond_to do |format|
        format.html {  }
        format.json { render json: @user.to_hash_profile, status: :ok }
      end
    end

    # PATCH /hello/user_password
    def update_password
      @user.password = user_params[:password]
      # @user.password_confirmation = user_params[:password_confirmation] if user_params[:password_confirmation]

      if @user.save
        flash[:notice] = @user_entity.success_message
        respond_to do |format|
          format.html { redirect_to hello.user_path }
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
