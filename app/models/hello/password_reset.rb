module Hello
  class PasswordReset
    include ActiveModel::Model

    attr_reader :identity

    def initialize(unencrypted_token=nil)
      if unencrypted_token
        find_identity(unencrypted_token)
      end
    end

    def update_password(password)
      identity.password = password
      merge_errors_to_self and return false unless identity.save
      return true
    end

    def errors
      @errors ||= ActiveModel::Errors.new(self)
    end




    private

        # initialize helpers

        def find_identity(unencrypted_token)
          token_digest = Identity.encrypt_token(unencrypted_token)
          query_hash   = {password_token_digest: token_digest}
          @identity    = Identity.strategy_password.where(query_hash).first
        end

        # update password helpers

        def merge_errors_to_self
          hash = identity.errors.to_hash
          hash.each { |k,v| v.each { |v1| errors.add(k, v1) } }
        end

        # helpers

  end
end
