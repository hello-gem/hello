module Hello
  class ConfirmEmailEntity < AbstractEntity

    include ActionView::Helpers::DateHelper

    attr_reader :credential

    def initialize(credential)
      @credential = credential
    end

    def validate_token(unencrypted_token)
      # puts "validate_token('#{unencrypted_token}')".blue
      return false if not found_credential?
      return true  if token_matches(unencrypted_token)
      @credential = nil
    end

    def confirm_with_token(token)
      if validate_token(token)
        confirm_email! and return true
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

    private

    def token_matches(unencrypted_token)
      Token.match(unencrypted_token, credential.email_token_digest)
    end

  end
end