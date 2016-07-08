module Hello
  module Concerns
    module Management
      module ForgotPassword

        def on_success
          reset_token_and_deliver_emails!

          respond_to do |format|
            format.html { render_success }
            format.json { render json: { sent: true }, status: :created }
          end
        end

        def on_failure
          respond_to do |format|
            format.html { render_form }
            format.json { render json: @forgot_password.errors, status: :unprocessable_entity }
          end
        end

        private

        def reset_token_and_deliver_emails!
          url = get_reset_password_url

          emails.each do |email|
            Mailer.forgot_password(email, @user, url).deliver
          end
        end

        def emails
          @user.email_credentials.map(&:email)
        end

        def get_reset_password_url
          p      = @user.password_credential
          token  = p.reset_verifying_token!
          hello.reset_password_url(p.id, @user.id, token)
        end

      end
    end
  end
end
