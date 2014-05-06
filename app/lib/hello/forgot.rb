Hello.config.forgot.config do
  
  # controller scope
  set :success do
    # @credential


    # rant, shouldn't this logic just be expressed inline here?
    deliver_password_forgot



    respond_to do |format|
      format.html {

        
        redirect_to hello.classic_forgot_welcome_path, notice: 'Check your mail box!'


      }
      format.json {

        # render json: @credential, status: :created, location: hello.classic_forgot_welcome_path
        

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

  set :deliver_password_forgot do
    # @credential

    if @credential.should_reset_password_token?
      token = @credential.reset_password_token
      url = hello.classic_reset_token_url(token)
      mailer = Hello::PasswordMailer.forgot(@credential, url)
      mailer.deliver
    end
  end



end

