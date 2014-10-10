class SignUpControl < Hello::AbstractControl
    
  alias :sign_up :entity

  def user_fields
    # %w(name)
    %w(name time_zone locale)
  end

  def defaults
    # {
    #   locale:    ('en'       if Hello.available_locales.include?('en')         ),
    #   time_zone: ('Brasilia' if Hello.available_time_zones.include?('Brasilia')),
    # }
    {
      locale:    I18n.locale.to_s,
      time_zone: Time.zone.name
    }
  end
  
  def success
    Hello::RegistrationMailer.welcome(sign_up.credential, sign_up.password).deliver

    active_session = c.create_hello_active_session

    c.respond_to do |format|
      format.html { c.redirect_to '/novice' }
      format.json { c.render json: active_session.as_json_api, status: :created }
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
