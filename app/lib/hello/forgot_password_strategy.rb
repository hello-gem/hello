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

    redirect_to hello.classic_after_forgot_path
  end

  failure_strategy do
    render :forgot
  end


end
