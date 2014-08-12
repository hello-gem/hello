Hello.config :sign_up do

  # permitted_fields :email, :password
  permitted_fields :name, :email, :username, :password, :city

  # variables avaliable:
  # @sign_in
  # @credential
  # @password
  
  success_strategy do

    Hello::RegistrationMailer.welcome(@credential).deliver
    # Hello::RegistrationMailer.welcome(@credential, password: @password).deliver

    hello_session = create_hello_session

    respond_to do |format|
      format.html { redirect_to hello.classic_after_sign_up_path }
      format.json { render json: hello_session.as_json_api, status: :created }
    end
  end

  failure_strategy do
    # SUGGESTION: suggest usernames if username has been taken
    # SUGGESTION: suggest 'forgot password' if email has been taken

    respond_to do |format|
      format.html { render :sign_up }
      format.json { render json: {errors: @sign_up.errors}, status: :unprocessable_entity }
    end
  end

end

