require_dependency "hello/application_controller"

module Hello
  class ConfirmEmailsController < ApplicationController

    before_actions do
      only(:confirm_token)   { @credential = Credential.take(params[:id]).first }
      except(:confirm_token) { before_actions_confirm_and_deliver }
    end



    # GET /hello/emails/1/confirm
    def confirm
    end

        # POST /hello/emails/1/confirm
        def deliver
          entity = SendConfirmationEmailEntity.new(self, @credential)
          entity.deliver
          flash[:notice] = entity.success_message
          redirect_to :back
        end

    # GET /hello/emails/1/confirm/:token
    def confirm_token
      entity = ConfirmEmailEntity.new(@credential)
      entity.validate_token(token_param)

      if entity.found_credential?
        entity.confirm_email!
        _ensure_signed_in(entity.credential.user)
        flash[:notice] = entity.success_message
        redirect_to confirmed_email_path(@credential)
      else
        flash[:alert] = entity.alert_message
        redirect_to expired_token_email_path(@credential || 0)
      end
    end

    # GET /hello/emails/1/expired_token
    def expired_token
    end

    # GET /hello/emails/1/confirmed
    def confirmed
    end


    private


        def before_actions_confirm_and_deliver
          restrict_to_users
          return if performed?

          @credential = hello_user.credentials.classic.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          redirect_to confirm_email_path(current_user.credentials.classic.first)
        end

        def _ensure_signed_in(user)
          create_hello_access_token(user) if current_user.nil?
        end

        def token_param
          params.require(:token)
        end

  end
end
