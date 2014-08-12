Hello.config :forgot_password do
  
  # variables avaliable:
  # 
  # @forgot_password
  # @credential

  success_strategy do
    digested_at = @credential.password_token_digested_at
    should_reset_password_token = (digested_at.blank? || digested_at < 7.days.ago)
    
    if should_reset_password_token
      token = @credential.reset_password_token
      url = hello.classic_reset_token_url(token)
      mailer = Hello::RegistrationMailer.forgot_password(@credential, url)
      mailer.deliver
    end

    
    respond_to do |format|
      format.html { redirect_to hello.classic_after_forgot_path }
      format.json { render json: {sent: true}, status: :created }
    end
  end

  failure_strategy do
    # SUGGESTION: register failed attempt

    respond_to do |format|
      format.html { render :forgot }
      format.json { render json: @forgot_password.errors, status: :unprocessable_entity }
    end
  end


end
