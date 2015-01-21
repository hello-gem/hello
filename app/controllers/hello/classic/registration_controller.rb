require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
module Classic
  class RegistrationController < ApplicationController

    # restrict_if_authenticated only: [
    # ]

    restrict_unless_authenticated only: [
      :confirm_email_send,
    ]

# either:    
# confirm_email_token
# after_confirm_email
# confirm_email_expired










    # GET /hello/confirm_email/send
    def confirm_email_send
      entity = SendConfirmationEmailEntity.new(self, hello_credential)
      entity.deliver
      flash[:notice] = entity.success_message
      redirect_to :back
    end

        # GET /hello/confirm_email/token/:token
        def confirm_email_token
          @confirm_email = ConfirmEmailEntity.new(params.require(:token))

          if @confirm_email.found_credential?
            @confirm_email.confirm_email!
            flash[:notice] = @confirm_email.success_message
            redirect_to after_confirm_email_path
          else
            flash[:alert] = @confirm_email.alert_message
            redirect_to confirm_email_expired_path
          end
        end

            # GET /hello/confirm_email/expired
            def confirm_email_expired
            end

            # GET /hello/after_confirm_email
            def after_confirm_email
            end





  end

end
end
