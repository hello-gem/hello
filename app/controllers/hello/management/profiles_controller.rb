module Hello
  module Management
    class ProfilesController < ApplicationController

      kick :guest, :onboarding, only: [:show, :update]

      before_action(only: [:show, :update]) do
        @user = current_user
        @user_business = Business::Management::UpdateProfile.new(@user)
      end

      # GET /hello/user
      def show
        respond_to do |format|
          format.html { render 'hello/management/user' }
          format.json { render json: @user.as_json_web_api, status: :ok }
        end
      end

      # PATCH /hello/user
      def update
        if @user_business.update(user_params)
          use_locale(current_user.locale)
          flash[:notice] = @user_business.success_message
          respond_to do |format|
            format.html { redirect_to hello.profile_path }
            format.json { render json: @user.as_json_web_api, status: :ok }
          end
        else
          render 'hello/management/user'
        end
      end




      dont_kick :user, only: [:cancel, :destroy]
      sudo_mode only: [:cancel, :destroy]

      # GET /hello/user/cancel
      def cancel
        render 'hello/management/cancel'
      end

      # DELETE /hello/user
      def destroy
        @cancel_account = Business::Management::CancelAccount.new(current_user)

        if @cancel_account.cancel_account
          flash[:notice] = @cancel_account.success_message
          respond_to do |format|
            format.html { redirect_to '/' }
            format.json { render json: { cancelled: true }, status: :ok }
          end
        else
          flash.now[:alert] = @cancel_account.alert_message
          respond_to do |format|
            format.html { render 'hello/management/cancel' }
            format.json { render json: { message: @cancel_account.alert_message }, status: :unprocessable_entity }
          end
        end
      end

      private

      def user_params
        params.require(:user)
      end
    end
  end
end
