Hello.config :sign_in do
  
  # variables avaliable:
  #
  # @sign_in
  # @credential
  
  success_strategy do
    expires_at = !!params[:keep_me] ? 30.days.from_now : 30.minutes.from_now
    hello_active_session = create_hello_active_session(expires_at)

    respond_to do |format|
      format.html { redirect_to session[:url] || hello.classic_after_sign_in_path }
      format.json { render json: hello_active_session.as_json_api, status: :created }
    end
  end

  failure_strategy do
    # SUGGESTION: register failed attempt if password was incorrect

    respond_to do |format|
      format.html { render :sign_in }
      format.json { render json: @sign_in.errors, status: :unprocessable_entity }
    end
  end

end
