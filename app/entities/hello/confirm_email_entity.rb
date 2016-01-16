module Hello
  class ConfirmEmailEntity < AbstractEntity
    include ActionView::Helpers::DateHelper

    attr_reader :credential

    def initialize(credential)
      @credential = credential
    end

    def validate_token(unencrypted_token)
      # puts "validate_token('#{unencrypted_token}')".blue
      return false unless found_credential?
      return true  if credential.verifying_token_is?(unencrypted_token)
      @credential = nil
    end

    def confirm_with_token(token)
      confirm_email! && (return true) if validate_token(token)
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
  end
end
