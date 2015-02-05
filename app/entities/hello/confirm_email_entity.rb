module Hello
  class ConfirmEmailEntity < AbstractEntity

    include ActionView::Helpers::DateHelper

    attr_reader :credential

    def initialize(credential)
      @credential = credential
    end

    def validate_token(unencrypted_token)
      return if not found_credential?
      token_digest = Credential.encrypt_token(unencrypted_token)
      
      return if @credential.email_token_digest == token_digest
      @credential = nil
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