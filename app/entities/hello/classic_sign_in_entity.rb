module Hello
  class ClassicSignInEntity < AbstractEntity
    attr_accessor :login, :password

    def authenticate(login, password)
      @ignited = true
      @login = login
      @password = password

      validates_presence_of :login, :password
      return false if any_errors?

      find_user_by_login
      check_login_found
      return false if any_errors?

      check_password_matches
      return false if any_errors?

      true
    end

    def bad_login?
      !!@bad_login
    end

    def bad_password?
      !!@bad_password
    end

    def user
      @user ||= ::User.new
    end

    private

    # authenticate helpers

    def any_errors?
      errors.full_messages.any?
    end

    def find_user_by_login
      @user = if login_is_email?
                find_user_by_login_email
              else
                find_user_by_login_username
      end
    end

    def find_user_by_login_email
      e = ::EmailCredential.find_by_email(login)
      e && e.user
    end

    def find_user_by_login_username
      ::User.where(username: login).first
    end

    def check_login_found
      add_errors_for_login_not_found if @user.nil?
    end

    def check_password_matches
      add_errors_for_password_incorrect unless user.password_is?(password)
    end

    def add_errors_for_login_not_found
      @bad_login = true
      errors.add(:login, 'was not found')
    end

    def add_errors_for_password_incorrect
      @bad_password = true
      errors.add(:password, 'is incorrect')
    end

    # helpers

    def login_is_email?
      login.to_s.include? '@'
    end

    def ignited
      @ignited || false
    end
  end
end
