class SignInControl < Hello::AbstractControl
  
  alias :sign_in :entity

  def success
    expires_at     = !!c.params[:keep_me] ? 30.days.from_now : 30.minutes.from_now
    active_session = c.create_hello_active_session(expires_at)

    c.respond_to do |format|
      format.html { c.redirect_to c.session.delete(:url) || c.hello.after_sign_in_path }
      format.json { c.render json: active_session.as_json_api, status: :created }
    end
  end

  def failure
    # SUGGESTION: register failed attempt if password was incorrect

    c.respond_to do |format|
      format.html { c.render :sign_in }
      format.json { c.render json: sign_in.errors, status: :unprocessable_entity }
    end
  end


end
