module Hello
  module Management
    class CurrentUsersController < ApplicationController
      include Hello::Concerns::UpdateProfileOnSuccess
      include Hello::Concerns::UpdateProfileOnFailure

      kick :guest, :onboarding

      before_action do
        @user_entity = CurrentUserEntity.new(@user = current_user)
      end

      # GET /hello/user
      def show
        respond_to do |format|
          format.html { render_edit_profile }
          format.json { render json: @user.as_json_web_api, status: :ok }
        end
      end

      # PATCH /hello/user
      def update
        if @user_entity.update(user_params)
          use_locale
          flash[:notice] = @user_entity.success_message
          on_success
        else
          on_failure
        end
      end

      private

      def user_params
        params.require(:user)
      end

      def render_edit_profile
        render 'hello/management/profile/edit'
      end
    end
  end
end
