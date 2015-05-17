module Hello
  class SignInEntity < AbstractEntity

    attr_accessor :login, :password
    attr_reader :user

    def initialize(attrs=nil)
      if attrs
        write_attributes_to_self(attrs)
        initialize_user
      end
    end

    def authenticate
      add_errors_for_login_not_found    and return false if not_found?
      add_errors_for_password_incorrect and return false if incorrect_password?
      return true
    end

    def not_found?
      initialized? && user.new_record?
    end

    def incorrect_password?
      was_login_found = initialized? && !not_found?
      was_login_found && !user.password_is?(password)
    end


    private

        # initialize helpers

        def initialize_user
          @user = if login_is_email
            credential = Credential.classic.where(email: login).first_or_initialize
            credential.build_user if credential.new_record?
            credential.user
          else
            User.where(username: login).first_or_initialize
          end
          
        end

        def write_attributes_to_self(attrs)
          attrs.permit(:login, :password).each { |k, v| instance_variable_set(:"@#{k}", v) }
        end

        # authenticate helpers

        def add_errors_for_login_not_found
          errors.add(:login, "was not found")
        end

        def add_errors_for_password_incorrect
          errors.add(:password, "is incorrect")
        end

        def initialized?
          !!user
        end

        # helpers

        # def key
        #   @key ||= login_is_email ? :email : :username
        # end

            def login_is_email
              login.to_s.include? '@'
            end



  end
end
