class ForgotPasswordControl < Hello::AbstractControl
  
  alias :forgot_password :entity

  def success
    @user = forgot_password.user

    reset_token_and_deliver_email! if should_reset_password_token?

    c.respond_to do |format|
      format.html { c.redirect_to c.hello.password_remembered_path }
      format.json { c.render json: {sent: true}, status: :created }
    end
  end

  def failure
    # SUGGESTION: register failed attempt

    c.respond_to do |format|
      format.html { c.render action: 'index' }
      format.json { c.render json: forgot_password.errors, status: :unprocessable_entity }
      # # To falsy show that the email was sent, please use the code below instead
      # format.html { c.redirect_to c.hello.password_remembered_path }
      # format.json { c.render json: {sent: true}, status: :created }
    end
  end





  private

  def reset_token_and_deliver_email!
    token  = @user.reset_password_token
    url    = c.hello.reset_token_url(token)
    @user.credentials.each do |credential|
      Hello::RegistrationMailer.forgot_password(credential, url).deliver
    end
  end

  def should_reset_password_token?
    true
    # SUGGESTION: Don't let users request a new password more than once a week
    # past_or_never?(@credential.password_token_digested_at, 7.days.ago)
  end

      # def past_or_never?(time1, time2)
      #   time1.blank? || (time1 < time2)
      # end

end
