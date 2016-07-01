module Hello
  module Concerns
    module Registration
      module SignUp

        def on_success
          deliver_welcome_email
          deliver_confirmation_email

          access_token = sign_in!(@sign_up.user, expires_at, sudo_mode_expires_at)

          respond_to do |format|
            format.html { redirect_to path_to_go }
            format.json { render json: access_token.as_json_web_api, status: :created }
          end
        end

        def on_failure
          respond_to do |format|
            format.html { render_sign_up }
            format.json { render json: @sign_up.errors, status: :unprocessable_entity }
          end
        end

        private

        def expires_at
          30.days.from_now
        end

        def sudo_mode_expires_at
          Hello.configuration.sudo_expires_in.from_now
        end

        def path_to_go
          '/onboarding'
        end

        def deliver_welcome_email
          Mailer.welcome(email, user, password).deliver
        end

        def deliver_confirmation_email
          token = email_credential.reset_verifying_token!
          url   = hello.confirm_email_url(email_credential, token)
          Mailer.confirm_email(email, user, url).deliver
        end

        def email
          email_credential.email
        end

        def email_credential
          @sign_up.email_credentials.first
        end

        def user
          @sign_up.user
        end

        def password
          @sign_up.password
        end

      end
    end
  end
end
