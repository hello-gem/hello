module Hello
  module Concerns
    module ForgotPasswordOnFailure

      def on_failure
        # SUGGESTION: register failed attempt

        respond_to do |format|
          format.html { render_form }
          format.json { render json: @forgot_password.errors, status: :unprocessable_entity }
          # # To falsy show that the email was sent, please use the code below instead
          # format.html { redirect_to hello.password_remembered_path }
          # format.json { render json: {sent: true}, status: :created }
        end
      end

    end
  end
end
