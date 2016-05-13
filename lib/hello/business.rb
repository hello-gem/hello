module Hello
  module Business
    extend ActiveSupport::Autoload

    # Business are used to encapsulate behaviors and translations

    # please keep alphabetical order

    autoload :Base

    module Authentication
      extend ActiveSupport::Autoload

      autoload :SignIn
      autoload :SignOut
      autoload :SudoModeAuthentication
      autoload :SudoModeExpiration
    end

    module Internationalization
      extend ActiveSupport::Autoload

      autoload :UpdateLocale
    end

    module Management
      extend ActiveSupport::Autoload

      autoload :AddEmail
      autoload :CancelAccount
      autoload :ConfirmEmail
      autoload :ForgotPassword
      autoload :RemoveEmail
      autoload :ResetPassword
      autoload :SendConfirmationEmail
      autoload :UnlinkAccess
      autoload :UpdateProfile
    end

    module Registration
      extend ActiveSupport::Autoload

      autoload :SignUp
    end

  end
end
