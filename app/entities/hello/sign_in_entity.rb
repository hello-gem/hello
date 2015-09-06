module Hello
  class SignInEntity < AbstractEntity

    attr_accessor :login, :password

    def authenticate(login, password)
      @login, @password = login, password

      add_errors_for_login_not_found    and return false if bad_login?
      add_errors_for_password_incorrect and return false if bad_password?
      return true
    end

    def bad_login?
      not found_user?
    end

    def bad_password?
      found_user? && !user.password_is?(password)
    end

    def user
      @user ||= if login_is_email?
        find_or_build_user_by_email
      else
        find_or_build_user_by_username
      end
    end

    private

        # authenticate helpers

        def find_or_build_user_by_email
          Credential.classic.find_by_email!(login).user
        rescue ActiveRecord::RecordNotFound
          User.new
        end

        def find_or_build_user_by_username
          User.where(username: login).first_or_initialize
        end

        def found_user?
          user.persisted?
        end

        def add_errors_for_login_not_found
          errors.add(:login, "was not found")
        end

        def add_errors_for_password_incorrect
          errors.add(:password, "is incorrect")
        end

        # helpers

        def login_is_email?
          login.to_s.include? '@'
        end

  end
end
