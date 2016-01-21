module Hello
  module Concerns
    module ResetPasswordOnSuccess

      def on_success
        # comment the line below in order to force the user to sign in manually
        access_token = sign_in!(@reset_password.user, expires_at)

        redirect_to '/'
      end

      private

      def expires_at
        30.days.from_now
      end

    end
  end
end
