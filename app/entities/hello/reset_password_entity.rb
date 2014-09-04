module Hello
  class ResetPasswordEntity < AbstractEntity

    attr_reader :credential

    def initialize(unencrypted_token=nil)
      if unencrypted_token
        @credential = find_credential(unencrypted_token)
      end
    end

    def update_password(password)
      credential.password = password
      merge_errors_to_self and return false unless credential.save
      return true
    end




    private

        # initialize helpers

        def find_credential(unencrypted_token)
          token_digest = Credential.encrypt_token(unencrypted_token)
          Credential.classic.where(password_token_digest: token_digest).first
        end

        # update password helpers

        def merge_errors_to_self
          hash = credential.errors.to_hash
          hash.each { |k,v| v.each { |v1| errors.add(k, v1) } }
        end

  end
end
