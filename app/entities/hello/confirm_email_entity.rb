module Hello
  class ConfirmEmailEntity < AbstractEntity

    include ActionView::Helpers::DateHelper

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
      t("info", email: credential.email, time_ago_in_words: time_ago_in_words(credential.email_token_digested_at, include_seconds: false))
    end




    private

        # initialize helpers

        def find_credential(unencrypted_token)
          token_digest = Credential.encrypt_token(unencrypted_token)
          Credential.classic.where(email_token_digest: token_digest).first
        end

  end
end