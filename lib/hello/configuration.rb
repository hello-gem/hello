module Hello

  # invoked from config/initializers/hello.rb
  def self.configure
    yield(configuration)
    apply_config!
  end

  # invoked internally
  def self.configuration
    @configuration ||= Rails.configuration.hello
  end

  # invoked from engine.rb
  def self.apply_config!
    configuration.extensions.tap do |ex|
      # User Registration
      EmailSignUpController.include    ex.email_sign_up
      # User Authentication
      EmailSignInController.include    ex.email_sign_in
      ForgotPasswordController.include ex.forgot_password
      ResetPasswordController.include  ex.reset_password
      # Account Management
      CurrentUsersController.include   ex.update_profile
      CancelAccountController.include  ex.cancel_account
    end
  end

end
