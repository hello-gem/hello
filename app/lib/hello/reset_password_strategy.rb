Hello.config :reset_password do

  # variables avaliable:
  #
  # @reset_password
  # @credential
  
  success_strategy do
    hello_session = create_hello_session

    redirect_to hello.classic_after_reset_path
  end

  failure_strategy do
    render :reset
  end

end

