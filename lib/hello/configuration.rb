module Hello

  # invoked from config/initializers/hello.rb
  def self.configure
    yield(configuration)
  end

  # invoked internally
  def self.configuration
    @configuration ||= ::Rails.configuration.hello
  end
  
  # invoked from engine.rb
  def self.apply_config!
    User.hello_apply_config!

    configuration.modules.tap do |m|
      # User Registration
      EmailSignUpController.send     :include, m.email_sign_up
      DeactivationController.send    :include, m.deactivation
      # User Authentication
      EmailSignInController.send     :include, m.email_sign_in
      ForgotPasswordController.send  :include, m.forgot_password
      ResetPasswordController.send   :include, m.reset_password
      SignOutController.send         :include, m.sign_out
      # Account Management
      CurrentUsersController.send    :include, m.update_profile

      # Internals
      SignUpEntity::Mod.send         :include, m.email_sign_up
    end
  end

end