module Hello

  # invoked from config/initializers/hello.rb
  def self.configure
    yield(configuration)
    apply_config!
  end

  # invoked internally
  def self.configuration
    @configuration ||= ::Rails.configuration.hello
  end

  # invoked from engine.rb
  def self.apply_config!
    if defined?(User)
      User.hello_apply_config!
    end

    configuration.extensions.tap do |ex|
      # User Registration
      EmailSignUpController.send     :include, ex.email_sign_up
      DeactivationController.send    :include, ex.deactivation
      # User Authentication
      EmailSignInController.send     :include, ex.email_sign_in
      ForgotPasswordController.send  :include, ex.forgot_password
      ResetPasswordController.send   :include, ex.reset_password
      SignOutController.send         :include, ex.sign_out
      # Account Management
      CurrentUsersController.send    :include, ex.update_profile

      # Internals
      SignUpEntity::Mod.send         :include, ex.email_sign_up
    end
  end

end
