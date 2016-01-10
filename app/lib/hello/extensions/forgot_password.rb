# Learn more at config/initializers/hello.rb
#
module Hello
  module Extensions
    module ForgotPassword
      def success
        reset_token_and_deliver_email! if should_reset_verifying_token?

        respond_to do |format|
          format.html { render_success }
          format.json { render json: { sent: true }, status: :created }
        end
      end

      def failure
        # SUGGESTION: register failed attempt

        respond_to do |format|
          format.html { render_form }
          format.json { render json: @forgot_password.errors, status: :unprocessable_entity }
          # # To falsy show that the email was sent, please use the code below instead
          # format.html { redirect_to hello.password_remembered_path }
          # format.json { render json: {sent: true}, status: :created }
        end
      end

      private

      def render_success
        render 'forgot'
      end

      def render_form
        render 'index'
      end

      def reset_token_and_deliver_email!
        p      = @user.main_password_credential
        token  = p.reset_verifying_token!
        url    = hello.reset_password_url(p.id, @user.id, token)
        @user.email_credentials.each do |email_credential|
          Hello::Mailer.forgot_password(email_credential, url).deliver
        end
      end

      def should_reset_verifying_token?
        true
        # SUGGESTION: Don't let users request a new password more than once a week
        # past_or_never?(@credential.password_token_digested_at, 7.days.ago)
      end

      # def past_or_never?(time1, time2)
      #   time1.blank? || (time1 < time2)
      # end
    end
  end
end
