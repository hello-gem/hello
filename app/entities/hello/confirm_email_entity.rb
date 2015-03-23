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
      token_digest = Hello.encrypt_token(unencrypted_token)
      
      # puts "return true if '#{credential.email_token_digest}' == '#{token_digest}'".blue
      return true if credential.email_token_digest == token_digest
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

  end
end