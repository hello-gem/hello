Hello.config.reset do
  
  # controller scope
  set :success do
    # @credential



    respond_to do |format|
      format.html {

        create_hello_session
        redirect_to hello.classic_after_reset_path, notice: 'Your password has been updated!'


      }
      format.json {

        # render json: @credential, status: :created, location: hello.classic_sign_in_path
        

      }
    end
  end


  set :error do
    #@credential
    # user = @credential.user

    # register failed attempt

    respond_to do |format|
      format.html {

        render :reset


      }
      format.json {
        
        # render json: @credential.errors, status: :unprocessable_entity
        

      }
    end
  end



end

