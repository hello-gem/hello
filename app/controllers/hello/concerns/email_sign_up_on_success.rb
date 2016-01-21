module Hello
  module Concerns
    module EmailSignUpOnSuccess

      def on_success
        deliver_welcome_email

        deliver_confirmation_email

        access_token = sign_in!(@sign_up.user, expires_at)

        respond_to do |format|
          format.html { redirect_to '/onboarding' }
          format.json { render json: access_token.as_json_web_api, status: :created }
        end
      end

      private

      def expires_at
        30.days.from_now
      end

      def deliver_welcome_email
        Hello::Mailer.welcome(@sign_up.email_credential, @sign_up.password).deliver
      end

      def deliver_confirmation_email
        token = @sign_up.email_credential.reset_verifying_token!
        url   = hello.confirm_email_url(@sign_up.email_credential, token)
        Hello::Mailer.confirm_email(@sign_up.email_credential, url).deliver
      end

    end
  end
end
