module Hello
  module Concerns
    module ClassicSignUpOnSuccess

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
        Mailer.welcome(email, user, password).deliver
      end

      def deliver_confirmation_email
        token = @sign_up.email_credential.reset_verifying_token!
        url   = hello.confirm_email_url(@sign_up.email_credential, token)
        Mailer.confirm_email(email, user, url).deliver
      end

      def email
        @sign_up.email_credential.email
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
