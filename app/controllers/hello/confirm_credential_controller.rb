require_dependency "hello/application_controller"

module Hello
  class ConfirmCredentialController < ApplicationController

    before_actions do
      only(:confirm_token)   { @credential = Credential.take(params[:id]).first }
      except(:confirm_token) { before_actions_confirm_and_deliver }
    end

    # GET /hello/credentials/1/confirm
    def confirm
    end

        # POST /hello/credentials/1/confirm
        def deliver
          entity = SendConfirmationEmailEntity.new(self, @credential)
          entity.deliver
          flash[:notice] = entity.success_message
          redirect_to :back
        end

    # GET /hello/credentials/1/confirm/token/:token
    def confirm_token
      entity = ConfirmEmailEntity.new(@credential)
      entity.validate_token(params.require(:token))

      if entity.found_credential?
        entity.confirm_email!
        _ensure_signed_in
        flash[:notice] = entity.success_message
        redirect_to confirm_done_credential_path(@credential)
      else
        flash[:alert] = entity.alert_message
        redirect_to confirm_expired_credential_path(@credential || 0)
      end
    end

    # GET /hello/credentials/1/confirm/expired
    def expired
    end

    # GET /hello/credentials/1/confirm/done
    def done
    end


    private


        def before_actions_confirm_and_deliver
          restrict_to_users
          return if performed?

          @credential = hello_user.credentials.classic.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          redirect_to confirm_credential_path(hello_credential)
        end

        def _ensure_signed_in
          create_hello_access_token if current_user.nil?
        end

  end
end
