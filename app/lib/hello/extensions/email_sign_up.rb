# Learn more at config/initializers/hello.rb
#
module Hello
  module Extensions
    module EmailSignUp

      def fields
        %w(name username time_zone locale)
      end

      def defaults
        {
          locale:    I18n.locale.to_s,
          time_zone: Time.zone.name
        }
      end

      def starting_role
        'onboarding'
      end

      def success
        deliver_welcome_email

        deliver_confirmation_email

        access_token = sign_in!(@sign_up.user, expires_at)

        respond_to do |format|
          format.html { redirect_to '/onboarding' }
          format.json { render json: access_token.to_json_web_api, status: :created }
        end
      end

      def failure
        respond_to do |format|
          format.html { render action: 'index' }
          format.json { render json: @sign_up.errors, status: :unprocessable_entity }
        end
      end

      private

      def expires_at
        30.days.from_now
      end

      def deliver_welcome_email
        Hello::RegistrationMailer.welcome(@sign_up.email_credential, @sign_up.password).deliver
      end

      def deliver_confirmation_email
        token = @sign_up.email_credential.reset_verifying_token!
        url   = hello.confirm_email_url(@sign_up.email_credential, token)
        Hello::RegistrationMailer.confirm_email(@sign_up.email_credential, url).deliver
      end

    end
  end
end
