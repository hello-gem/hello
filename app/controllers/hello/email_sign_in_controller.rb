module Hello
  class EmailSignInController < SuperEmailSignInController

    def success
      access_token = create_access_token_for(@sign_in.user, expires_at)

      respond_to do |format|
        format.html { redirect_to session.delete(:url) || hello.authenticated_path }
        format.json { render json: access_token.as_json_api, status: :created }
      end
    end

    def failure
      # SUGGESTION: register failed attempt if password was incorrect

      respond_to do |format|
        format.html { render action: 'index' }
        format.json { render json: @sign_in.errors, status: :unprocessable_entity }
      end
    end



    def expires_at
      if params[:keep_me]
        30.days.from_now
      else
        30.minutes.from_now
      end
    end



  end
end
