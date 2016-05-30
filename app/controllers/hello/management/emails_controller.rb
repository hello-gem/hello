module Hello
  module Management
    class EmailsController < ApplicationController
      kick :guest, :onboarding
      sudo_mode

      helper_method :credentials

      before_actions do
        only(:index)  { @credential = ::EmailCredential.new }
        only(:create) { @credential = current_user.email_credentials.build(email_credential_params) }
        only(:destroy, :deliver) { @credential = current_user.email_credentials.find(params[:id]) }
      end

      # GET /hello/emails
      def index
        render_list
      end

      # POST /hello/emails
      def create
        business = Business::Management::AddEmail.new(@credential)
        if @credential.save
          redirect_to hello.emails_path, notice: business.success_message
        else
          flash.now[:alert] = business.error_message
          render_list
        end
      end

      # DELETE /hello/emails/1
      def destroy
        business = Business::Management::RemoveEmail.new(@credential)
        if @credential.destroy
          redirect_to hello.emails_path, notice: business.success_message
        else
          flash.now[:alert] = business.error_message
          render_list
        end
      end

      # POST /hello/emails/1/deliver
      def deliver
        business = Business::Management::SendConfirmationEmail.new(self, @credential)
        business.deliver
        flash[:notice] = business.success_message
        redirect_to hello.emails_path
      end

      private

      # Only allow a trusted parameter "white list" through.
      def email_credential_params
        params.require(:email_credential).permit(:email)
      end

      def credentials
        # TODO: this is necessary to hide a temporary bug, must solve this later
        current_user.credentials.where(type: 'EmailCredential')
      end

      def render_list
        render 'hello/management/email_credentials/index'
      end
    end
  end
end
