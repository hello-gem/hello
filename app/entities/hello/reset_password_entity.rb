module Hello
  class ResetPasswordEntity < AbstractEntity

    attr_reader :user

    def initialize(unencrypted_token=nil)
      if unencrypted_token
        @user = find_user(unencrypted_token)
      end
    end

    def update_password(password)
      simply_update_password(password)
      @user.invalidate_password_token
    end

    private

        # initialize helpers

        def find_user(unencrypted_token)
          token_digest = Hello.encrypt_token(unencrypted_token)
          User.where(password_token_digest: token_digest).first
        end

        # update password helpers

        def simply_update_password(password)
          user.password = password
          merge_errors_to_self and return false unless user.save
          return true
        end

            def merge_errors_to_self
              hash = user.errors.to_hash
              hash.each { |k,v| v.each { |v1| errors.add(k, v1) } }
            end

  end
end
