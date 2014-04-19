Hello.forgot.config do
  
  # controller scope
  success do
    # @identity

    # SignUpMailer.forgot(@identity).deliver
    deliver_password_forgot



    respond_to do |format|
      format.html {

        
        redirect_to hello.password_forgot_welcome_path, notice: 'Check your mail box!'


      }
      format.json {

        # render json: @identity, status: :created, location: hello.password_forgot_welcome_path
        

      }
    end
  end


  error do
    #@identity
    # user = @identity.user

    # register failed attempt if email was found

    respond_to do |format|
      format.html {

        render :forgot


      }
      format.json {
        
        # render json: @identity.errors, status: :unprocessable_entity
        

      }
    end
  end

  deliver_password_forgot do
    # @identity

    if @identity.should_reset_token?
      token = @identity.reset_token
      url = hello.password_forgot_url(token: token)
      mailer = Hello::PasswordMailer.forgot(@identity, url)
      mailer.deliver
    end
  end



end

