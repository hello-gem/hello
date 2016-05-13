module Hello
  module Management
    class PasswordsController < ApplicationController
      kick :guest, :onboarding
      sudo_mode

      before_action do
        @password_credential = current_user.password_credential || fail(ActiveRecord::NotFound)
        @update_profile = Business::Management::UpdateProfile.new(@password_credential)
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
          format.html { render_password_view }
          format.json { head :no_content }
        end
      end

      # PATCH /hello/passwords/1
      def update
        @password_credential.password = password_credential_params[:password]
        # @password_credential.password_confirmation = password_credential_params[:password_confirmation] if password_credential_params[:password_confirmation]

        if @password_credential.save
          respond_to do |format|
            format.html { redirect_to hello.password_path(@password_credential), notice: @update_profile.success_message }
            format.json { head :no_content }
          end
        else
          respond_to do |format|
            format.html { render_password_view }
            format.json { render json: @password_credential.errors, status: :unprocessable_entity }
          end
        end
      end

      private

      def password_credential_params
        params.require(:password_credential)
      end

      def render_password_view
        render 'hello/management/password_credentials/show'
      end
    end
  end
end
