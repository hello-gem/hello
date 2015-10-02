module Hello
  class ForgotPasswordEntity < AbstractEntity

    attr_accessor :login
    attr_reader :user

    def initialize(attrs=nil)
      if attrs
        @login      = attrs[:login]
        @user = find_user
      end
    end

    def reset
      add_errors_for_login_not_found and return false if user.nil?
      return true
    end

    def email?
      login.to_s.include? '@'
    end


    def success_message(extra={})
      super(login: @login)
    end




    private

        # initialize helpers

        def find_user
          if email?
            credential = EmailCredential.find_by_email(login)
            credential.user
          else
            User.where(username: login).first
          end
        end

        # reset helpers

        def add_errors_for_login_not_found
          errors.add(:login, "was not found")
        end

  end
end
