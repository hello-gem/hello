module Hello
  class ResetPasswordController < SuperResetPasswordController

    def success
      # comment the line below in order to force the user to sign in manually
      access_token = create_hello_access_token(@reset_password.user, expires_at)

      redirect_to hello.password_reset_done_path
    end

    def failure
      render action: 'index'
    end



    def expires_at
      30.days.from_now
    end

  end
end
