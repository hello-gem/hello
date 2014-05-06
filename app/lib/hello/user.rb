Hello.config.user.config do
  
  # controller scope
  set :success do
    # @user


    respond_to do |format|
      format.html {

        redirect_to hello.user_path, notice: 'Your profile was successfully updated.'

      }
      format.json {

        # render json: @credential, status: :created, location: hello.password_sign_in_welcome_path

      }
    end
  end


  set :error do
    # @user

    respond_to do |format|
      format.html {

        render :edit

      }
      format.json {
        
        # render json: @user.errors, status: :unprocessable_entity

      }
    end
  end



end

