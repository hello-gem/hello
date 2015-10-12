module Hello
  class CurrentUsersController < ApplicationController

    kick :guest, :onboarding

    before_action do
      @user_entity = UpdateCurrentUserEntity.new(@user = current_user)
    end

    # GET /hello/user
    def show
      respond_to do |format|
        format.html {  }
        format.json { render json: @user.to_json_web_api, status: :ok }
      end
    end

    # PATCH /hello/user
    def update
      if @user_entity.update(user_params)
        use_locale
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
