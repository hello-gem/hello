Hello.config :user do
  
  # variables avaliable:
  #
  # @sign_in
  # @user
  
  success_strategy do
    respond_to do |format|
      format.html { redirect_to hello.user_path }
      # format.json { render json: @user, status: :ok }
    end
  end


  failure_strategy do
    respond_to do |format|
      format.html { render :edit }
      #format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

end
