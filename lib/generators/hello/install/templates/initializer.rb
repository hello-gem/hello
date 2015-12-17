Hello.configure do |config|

  config.mailer_sender = 'hello@example.com'

  config.password_length = 4..200
  config.username_length = 4..32
  config.username_regex  = /\A[a-z0-9_-]+\z/i

  # User Registration
  config.email_sign_up_role          = 'onboarding'
  config.email_sign_up_fields        = %w(name username time_zone locale)
  config.extensions.email_sign_up    = Hello::Extensions::EmailSignUp
  # User Authentication
  config.extensions.email_sign_in    = Hello::Extensions::EmailSignIn
  config.extensions.forgot_password  = Hello::Extensions::ForgotPassword
  config.extensions.reset_password   = Hello::Extensions::ResetPassword
  config.extensions.encrypt_password = Hello::Extensions::EncryptPassword
  # Account Management
  config.extensions.update_profile   = Hello::Extensions::UpdateProfile
  config.extensions.cancel_account   = Hello::Extensions::CancelAccount

end
