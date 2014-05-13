Hello.config.forgot do
  
  # controller scope
  set :success do
    # @credential

    digested_at = @credential.password_token_digested_at
    should_reset_password_token = (digested_at.blank? || digested_at < 7.days.ago)
    
    if should_reset_password_token
      token = @credential.reset_password_token
      url = hello.classic_reset_token_url(token)
      mailer = Hello::PasswordMailer.forgot(@credential, url)
      mailer.deliver
    end



    respond_to do |format|
      format.html {

        
        redirect_to hello.classic_after_forgot_path, notice: 'Check your mail box!'


      }
      format.json {

        # render json: @credential, status: :created, location: hello.classic_after_forgot_path
        

      }
    end
  end


  set :error do
    #@credential
    # user = @credential.user

    # register failed attempt if email was found

    respond_to do |format|
      format.html {

        render :forgot


      }
      format.json {
        
        # render json: @credential.errors, status: :unprocessable_entity
        

      }
    end
  end


end

