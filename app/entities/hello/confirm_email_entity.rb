module Hello
  class ConfirmEmailEntity < AbstractEntity

    attr_reader :credential

    def initialize(value=nil)
      @credential = if value.is_a? Credential
                      value
                    else
                      find_credential(value)
                    end
    end

    def confirm_email!
      credential.confirm_email!
    end

    def found_credential?
      !!credential
    end

    def success_message
      super(email: credential.email)
    end

    def info_message
      t("info", email: credential.email)
    end




    private

        # initialize helpers

        def find_credential(unencrypted_token)
          token_digest = Credential.encrypt_token(unencrypted_token)
          Credential.classic.where(email_token_digest: token_digest).first
        end

  end
end