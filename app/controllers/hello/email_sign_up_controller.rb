module Hello
  class EmailSignUpController < SuperEmailSignUpController

    def success
      deliver_welcome_email

      access_token = create_hello_access_token(@sign_up.user, expires_at)

      respond_to do |format|
        format.html { redirect_to '/novice' }
        format.json { render json: access_token.as_json_api, status: :created }
      end
    end

    def failure
      # SUGGESTION: suggest usernames if username has been taken
      # SUGGESTION: suggest 'forgot password' if email has been taken

      respond_to do |format|
        format.html { render action: 'index', layout: true }
        format.json { render json: @sign_up.errors, status: :unprocessable_entity }
      end
    end



    def expires_at
      30.days.from_now
    end

    def deliver_welcome_email
      Hello::RegistrationMailer.welcome(@sign_up.credential, @sign_up.password).deliver
    end

  end
end
