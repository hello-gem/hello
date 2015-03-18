class ResetPasswordControl < Hello::AbstractControl
  
  alias :reset_password :entity

  def success
    access_token = c.create_hello_access_token(reset_password.user)

    c.redirect_to c.hello.password_reset_done_path
  end

  def failure
    c.render action: 'index'
  end


end
