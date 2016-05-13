module Hello
  module Business
    module Management
      class ResetPassword < Base
        attr_reader :password_credential

        def initialize(password_credential)
          @password_credential = password_credential
        end

        def update_password(plain_text_password)
          if @password_credential.update(password: plain_text_password)
            @password_credential.reset_verifying_token!
            return true
          else
            merge_errors_to_self
            return false
          end
        end

        def user
          password_credential.user
        end

        private

        def merge_errors_to_self
          hash = @password_credential.errors.to_hash
          hash.each { |k, v| v.each { |v1| errors.add(k, v1) } }
        end
      end
    end
  end
end
