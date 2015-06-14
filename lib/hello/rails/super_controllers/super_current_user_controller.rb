module Hello
  class SuperCurrentUserController < ApplicationController

    restrict_to_users

    before_action do
      @user_entity = UpdateMyUserEntity.new(@user = current_user)
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
      if @user_entity.update(user_params)
        hello_ensure_thread_locale
        flash[:notice] = @user_entity.success_message
        success
      else
        failure
      end
    end



    private

    def user_params
      params.require(:user)
    end
    
  end
end
