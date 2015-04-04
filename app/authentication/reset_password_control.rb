class ResetPasswordControl < Hello::AbstractControl
  
  alias :reset_password :entity

  def success
    access_token = c.create_hello_access_token(reset_password.user, expires_at)

    c.redirect_to c.hello.password_reset_done_path
  end

  def failure
    c.render action: 'index'
  end



  private

  def expires_at
    30.days.from_now
  end

end
