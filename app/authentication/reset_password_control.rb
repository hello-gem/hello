class ResetPasswordControl < Hello::AbstractControl
  
  alias :reset_password :entity

  def success
    access_token = c.create_hello_access_token

    c.redirect_to c.hello.after_reset_path
  end

  def failure
    c.render :reset
  end


end
