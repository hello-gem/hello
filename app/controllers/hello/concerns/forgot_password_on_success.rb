module Hello
  module Concerns
    module ForgotPasswordOnSuccess

      def on_success
        reset_token_and_deliver_email! if should_reset_verifying_token?

        respond_to do |format|
          format.html { render_success }
          format.json { render json: { sent: true }, status: :created }
        end
      end

      private

      def reset_token_and_deliver_email!
        p      = @user.main_password_credential
        token  = p.reset_verifying_token!
        url    = hello.reset_password_url(p.id, @user.id, token)
        @user.email_credentials.map(&:email).each do |email|
          Mailer.forgot_password(email, @user, url).deliver
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
