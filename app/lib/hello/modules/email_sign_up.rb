# Generated with gem 'hello', '<%= Hello::VERSION %>'
# Learn more at config/initializers/hello.rb
#
module Hello
  module Modules
    module EmailSignUp

      def fields
        %w(name username password time_zone locale)
      end

      def defaults
        {
          locale:    I18n.locale.to_s,
          time_zone: Time.zone.name
        }
      end

      # YOUR VARIABLES
      #
      # @errors
      # @user
      # @credential
      #
      def success
        deliver_welcome_email

        deliver_confirmation_email

        access_token = sign_in!(@user, expires_at)

        respond_to do |format|
          format.html { redirect_to '/novice' }
          format.json { render json: access_token.to_json_web_api, status: :created }
        end
      end

      def failure
        respond_to do |format|
          format.html { render action: 'index' }
          format.json { render json: @errors, status: :unprocessable_entity }
        end
      end

      private

      def expires_at
        30.days.from_now
      end

      def deliver_welcome_email
        Hello::RegistrationMailer.welcome(@credential, @user.password).deliver
      end

      def deliver_confirmation_email
        token = @credential.reset_email_token!
        url   = hello.confirm_email_url(@credential, token)
        Hello::RegistrationMailer.confirm_email(@credential, url).deliver
      end
      
    end
  end
end
