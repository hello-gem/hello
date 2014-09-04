module Hello
  
  class SignIn
    include ActiveModel::Model

    attr_accessor :login, :password
    attr_reader :credential

    def initialize(attrs=nil)
      if attrs
        write_attributes_to_self(attrs)
        initialize_credential
      end
    end

    def authenticate
      add_errors_for_login_not_found    and return false if credential.new_record?
      add_errors_for_password_incorrect and return false if not credential.password_is?(password)
      return true
    end

    def errors
      @errors ||= ActiveModel::Errors.new(self)
    end

    def error_message
      I18n.t("hello.messages.classic.registration.sign_in.error", count: errors.count)
    end




    private

        # initialize helpers

        def initialize_credential
          @credential = Credential.classic.where(key => login).first_or_initialize
        end

        def write_attributes_to_self(attrs)
          attrs.permit(:login, :password).each { |k, v| instance_variable_set(:"@#{k}", v) }
        end

        # authenticate helpers

        def add_errors_for_login_not_found
          errors.add(key, "was not found")
        end

        def add_errors_for_password_incorrect
          errors.add(:password, "is incorrect")
        end

        # helpers

        def key
          @key ||= login_is_email ? :email : :username
        end

            def login_is_email
              login.to_s.include? '@'
            end



  end
end
