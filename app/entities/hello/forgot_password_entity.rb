module Hello
  class ForgotPasswordEntity < AbstractEntity

    attr_accessor :login
    attr_reader :credential

    def initialize(attrs=nil)
      if attrs
        @login      = attrs[:login]
        @credential = find_credential
      end
    end

    def reset
      add_errors_for_login_not_found and return false if credential.nil?
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

        def find_credential
          Credential.classic.where(key => login).first
        end

        # reset helpers

        def add_errors_for_login_not_found
          errors.add(:login, "was not found")
        end

        # helpers

        def key
          @key ||= email? ? :email : :username
        end

  end
end
