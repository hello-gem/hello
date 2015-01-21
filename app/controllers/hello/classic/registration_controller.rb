require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
module Classic
  class RegistrationController < ApplicationController

    restrict_if_authenticated only: [
      :forgot, :ask, :after_forgot,
      :reset_token, :reset, :save,
    ]

    restrict_unless_authenticated only: [
      :confirm_email_send,
    ]

# either:    
# after_reset
# confirm_email_token
# after_confirm_email
# confirm_email_expired









    # GET /hello/forgot
    def forgot
      @forgot_password = ForgotPasswordEntity.new
    end

        # POST /hello/forgot
        def ask
          @forgot_password = ForgotPasswordEntity.new(params.require(:forgot_password))
          @credential = @forgot_password.credential

          control = ForgotPasswordControl.new(self, @forgot_password)

          if @forgot_password.reset
            # flash[:notice] = @forgot_password.success_message
            control.success
          else
            control.failure
          end
          
          session[:forgot_login] = @forgot_password.login
        end

            # GET /hello/after_forgot
            def after_forgot
              @forgot_password = ForgotPasswordEntity.new
              @forgot_password.login = session[:forgot_login]
            end





    # GET /hello/reset/token/:token
    def reset_token
      destroy_and_clear_hello_access_token
      @reset_password = ResetPasswordEntity.new(params[:token])

      if @reset_password.credential
        session[:hello_reset_token] = params[:token]
        redirect_to reset_password_path
      else
        flash[:alert] = @reset_password.alert_message
        redirect_to forgot_password_path
      end
    end

        # GET /hello/reset
        def reset
          fetch_registration_reset_ivar
        end

            # POST /hello/reset
            def save
              fetch_registration_reset_ivar
              control = ResetPasswordControl.new(self, @reset_password)

              new_password = params.require(:reset_password)[:password]
              if @reset_password.update_password(new_password)
                @credential.invalidate_password_token
                flash[:notice] = @reset_password.success_message
                control.success
              else
                control.failure
              end
            end

                # GET /hello/after_reset
                def after_reset
                end



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


    private

        def fetch_registration_reset_ivar
          return redirect_to forgot_path unless session[:hello_reset_token]
          @reset_password = ResetPasswordEntity.new(session[:hello_reset_token])
          @credential = @reset_password.credential
        end




  end

end
end
