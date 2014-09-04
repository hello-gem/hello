class ForgotPasswordControl < Hello::AbstractControl
  
  alias :forgot_password :entity

  def success
    credential = forgot_password.credential

    digested_at = credential.password_token_digested_at
    should_reset_password_token = (digested_at.blank? || digested_at < 7.days.ago)
    
    if should_reset_password_token
      token  = credential.reset_password_token
      url    = c.hello.classic_reset_token_url(token)
      Hello::RegistrationMailer.forgot_password(credential, url).deliver
    end

    c.respond_to do |format|
      format.html { c.redirect_to c.hello.classic_after_forgot_path }
      format.json { c.render json: {sent: true}, status: :created }
    end
  end

  def failure
    # SUGGESTION: register failed attempt

    c.respond_to do |format|
      format.html { c.render :forgot }
      format.json { c.render json: forgot_password.errors, status: :unprocessable_entity }
    end
  end


end
