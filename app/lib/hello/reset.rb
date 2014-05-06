Hello.config.reset.config do
  
  # controller scope
  set :success do
    # @identity



    respond_to do |format|
      format.html {

        # create_hello_session
        redirect_to hello.classic_sign_in_path, notice: 'Your password has been updated!'


      }
      format.json {

        # render json: @identity, status: :created, location: hello.classic_sign_in_path
        

      }
    end
  end


  set :error do
    #@identity
    # user = @identity.user

    # register failed attempt

    respond_to do |format|
      format.html {

        render :reset


      }
      format.json {
        
        # render json: @identity.errors, status: :unprocessable_entity
        

      }
    end
  end



end

