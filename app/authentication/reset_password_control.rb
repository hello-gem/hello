class ResetPasswordControl < Hello::AbstractControl
  
  alias :reset_password :entity

  def success
    active_session = c.create_hello_active_session

    c.redirect_to c.hello.after_reset_path
  end

  def failure
    c.render :reset
  end


end
