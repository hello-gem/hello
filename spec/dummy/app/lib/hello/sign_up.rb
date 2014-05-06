# fname = __FILE__.split('/').last
# original = File.expand_path("../../../../../../app/lib/hello/#{fname}", __FILE__)
# require original

Hello.config.sign_up.config do
  
  # fields :email, :password
  fields :name, :email, :username, :password, :city

  # controller scope
  set :success do
    #@identity
    # user = @identity.user



    # SignUpMailer.welcome(@identity).deliver
    # SignUpMailer.confirmation(@identity).deliver



    respond_to do |format|
      format.html {

        # create_hello_session
        redirect_to hello.classic_sign_up_welcome_path, notice: 'Welcome!'


      }
      format.json {

        # render json: @identity, status: :created, location: hello.classic_sign_up_welcome_path
        

      }
    end
  end


  set :error do
    #@identity
    # user = @identity.user

    # register failed attempt if email was found

    respond_to do |format|
      format.html {

        render :sign_up


      }
      format.json {
        
        # render json: @identity.errors, status: :unprocessable_entity
        

      }
    end
  end



end

