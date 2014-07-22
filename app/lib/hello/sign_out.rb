Hello.config.sign_out do
  
  # controller scope
  set :success do

    respond_to do |format|
      format.html {

        # redirect_to hello.root_path
        # redirect_to root_path
        render :sign_out


      }
      format.json {
        # render json: true, status: :ok
      }
    end
  end



end

