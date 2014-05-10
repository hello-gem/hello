module Hello
  class RegistrationForgot
    include ActiveModel::Model

    attr_accessor :login
    attr_reader :credential

    def initialize(login=nil)
      if login
        @login = login
        find_credential
      end
    end

    def reset
      add_errors_for_login_not_found and return false if credential.nil?
      return true
    end

    def errors
      @errors ||= ActiveModel::Errors.new(self)
    end




    private

        # initialize helpers

        def find_credential
          @credential = Credential.classic.where(key => login).first
        end

        # reset helpers

        def add_errors_for_login_not_found
          errors.add(:login, "was not found")
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
