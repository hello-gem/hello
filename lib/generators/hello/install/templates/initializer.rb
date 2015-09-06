Hello.configure do |config|

  config.mailer_sender = 'hello@example.com'
  
  config.password_length = 4..200
  config.username_length = 4..32
  config.username_regex  = /\A[a-z0-9_-]+\z/i



  # User Registration
  config.modules.email_sign_up    = Hello::Modules::EmailSignUp
  config.modules.deactivation     = Hello::Modules::Deactivation
  # User Authentication
  config.modules.email_sign_in    = Hello::Modules::EmailSignIn
  config.modules.forgot_password  = Hello::Modules::ForgotPassword
  config.modules.reset_password   = Hello::Modules::ResetPassword
  config.modules.sign_out         = Hello::Modules::SignOut
  config.modules.encrypt_password = Hello::Modules::EncryptPassword
  # Account Management
  config.modules.update_profile   = Hello::Modules::UpdateProfile

end
