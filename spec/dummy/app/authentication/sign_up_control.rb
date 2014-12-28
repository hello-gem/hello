class SignUpControl < Hello::AbstractControl
    
  alias :sign_up :entity

  def user_fields
    # %w(name)
    # %w(name time_zone locale)
    %w(name time_zone locale city)
  end

  def defaults
    {
      locale:    I18n.locale.to_s,
      time_zone: Time.zone.name
    }
  end
  
  def success
    Hello::RegistrationMailer.welcome(sign_up.credential, sign_up.password).deliver

    access_token = c.create_hello_access_token

    c.respond_to do |format|
      format.html { c.redirect_to '/novice' }
      format.json { c.render json: access_token.as_json_api, status: :created }
    end
  end

  def failure
    # SUGGESTION: suggest usernames if username has been taken
    # SUGGESTION: suggest 'forgot password' if email has been taken

    c.respond_to do |format|
      format.html { c.render :sign_up }
      format.json { c.render json: sign_up.errors, status: :unprocessable_entity }
    end
  end

end
