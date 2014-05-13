# fname = __FILE__.split('/').last
# original = File.expand_path("../../../../../../app/lib/hello/#{fname}", __FILE__)
# require original

Hello.config.sign_up do
  
  # fields :email, :password
  fields :name, :email, :username, :password, :city

  # controller scope
  set :success do
    #@credential
    # user = @credential.user



    # SignUpMailer.welcome(@credential).deliver
    # SignUpMailer.confirmation(@credential).deliver



    respond_to do |format|
      format.html {

        create_hello_session
        redirect_to hello.classic_after_sign_up_path, notice: 'Welcome!'


      }
      format.json {

        # render json: @credential, status: :created, location: hello.classic_after_sign_up_path
        

      }
    end
  end


  set :error do
    #@credential
    # user = @credential.user

    # register failed attempt if email was found

    respond_to do |format|
      format.html {

        render :sign_up


      }
      format.json {
        
        # render json: @credential.errors, status: :unprocessable_entity
        

      }
    end
  end



end

