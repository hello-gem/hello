module Hello
  class ResetPasswordEntity < AbstractEntity

    attr_reader :password_credential

    def initialize(unencrypted_token=nil)
      if unencrypted_token
        @password_credential = find_password_credential(unencrypted_token)
      end
    end

    def update_password(plain_text_password)
      simply_update_password(plain_text_password)
      @password_credential.invalidate_password_token
    end

    def user
      password_credential.user
    end

    private

        # initialize helpers

        def find_password_credential(unencrypted_token)
          digest = Token.encrypt(unencrypted_token)
          PasswordCredential.where(reset_token_digest: digest).first
        end

        # update password helpers

        def simply_update_password(password)
          @password_credential.password = password
          merge_errors_to_self and return false unless @password_credential.save
          return true
        end

            def merge_errors_to_self
              hash = @password_credential.errors.to_hash
              hash.each { |k,v| v.each { |v1| errors.add(k, v1) } }
            end

  end
end
