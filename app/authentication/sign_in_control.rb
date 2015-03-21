class SignInControl < Hello::AbstractControl
  
  alias :sign_in :entity

  def success
    access_token = c.create_hello_access_token(sign_in.user, expires_at)

    c.respond_to do |format|
      format.html { c.redirect_to c.session.delete(:url) || c.hello.authenticated_path }
      format.json { c.render json: access_token.as_json_api, status: :created }
    end
  end

  def failure
    # SUGGESTION: register failed attempt if password was incorrect

    c.respond_to do |format|
      format.html { c.render action: 'index' }
      format.json { c.render json: sign_in.errors, status: :unprocessable_entity }
    end
  end



  private

  def expires_at
    if c.params[:keep_me]
      30.days.from_now
    else
      30.minutes.from_now
    end
  end



end
