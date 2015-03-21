require_dependency "hello/application_controller"

module Hello
  class ConfirmEmailsController < ApplicationController

    before_actions do
      all { destroy_and_clear_hello_access_token }
      only(:confirm) { @credential = Credential.where(id: params[:id]).first }
    end

    # GET /hello/emails/1/confirm/:token
    def confirm
      entity = ConfirmEmailEntity.new(@credential)

      if entity.validate_token(params[:token])
        entity.confirm_email!
        sign_in_with_sudo_mode
        flash[:notice] = entity.success_message
        redirect_to emails_path
      else
        flash[:alert] = entity.alert_message
        redirect_to expired_token_emails_path
      end
    end

    # GET /hello/emails/1/expired_token
    def expired_token
    end

    private

    def sign_in_with_sudo_mode
      access_token = create_hello_access_token(@credential.user, 1.hour.from_now)
      access_token.update! sudo_expires_at: 60.seconds.from_now
    end

  end
end
