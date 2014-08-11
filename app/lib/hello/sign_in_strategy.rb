Hello.config :sign_in do
  
  # variables avaliable:
  #
  # @sign_in
  # @credential
  
  success_strategy do
    keep_me = !!params[:keep_me]
    hello_session = create_hello_session(keep_me)

    respond_to do |format|
      format.html { redirect_to hello.classic_after_sign_in_path }
      format.json { render json: hello_session.to_json_api, status: :created }
    end
  end

  failure_strategy do
    # SUGGESTION: register failed attempt if password was incorrect

    respond_to do |format|
      format.html { render :sign_in }
      format.json { render json: {errors: @sign_in.errors}, status: :unprocessable_entity }
    end
  end

end
