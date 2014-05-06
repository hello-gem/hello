module Hello
  class PasswordSignIn
    include ActiveModel::Model

    attr_accessor :login, :password
    attr_reader :credential, :controller

    def initialize(controller=nil)
      if controller
        write_attributes_to_self(controller)
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




    private

        # initialize helpers

        def write_attributes_to_self(controller)
          attrs = controller.params.slice(:login, :password)
          attrs[:controller] = controller
          attrs.each { |k, v| instance_variable_set(:"@#{k}", v) }
        end

        def initialize_credential
          @credential = Credential.classic.where(key => login).first_or_initialize
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
