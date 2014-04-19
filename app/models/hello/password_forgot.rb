module Hello
  class PasswordForgot
    include ActiveModel::Model

    attr_accessor :login
    attr_reader :identity

    def initialize(login=nil)
      if login
        @login = login
        find_identity
      end
    end

    def reset
      add_errors_for_login_not_found and return false if identity.nil?
      return true
    end

    def errors
      @errors ||= ActiveModel::Errors.new(self)
    end




    private

        # initialize helpers

        def find_identity
          query_hash = {key => login, strategy: 'password'}
          @identity = Identity.where(query_hash).first
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
