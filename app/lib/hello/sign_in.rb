Hello.config.sign_in.config do
  
  # controller scope
  set :success do
    #@identity
    # user = @identity.user



    # SignUpMailer.welcome(@identity).deliver
    # SignUpMailer.confirmation(@identity).deliver



    respond_to do |format|
      format.html {

        create_hello_session
        redirect_to hello.password_sign_in_welcome_path, notice: 'Welcome!'


      }
      format.json {

        # render json: @identity, status: :created, location: hello.password_sign_in_welcome_path
        

      }
    end
  end


  set :error do
    #@identity
    # user = @identity.user

    # register failed attempt if email was found

    respond_to do |format|
      format.html {

        render :sign_in


      }
      format.json {
        
        # render json: @identity.errors, status: :unprocessable_entity
        

      }
    end
  end



end

