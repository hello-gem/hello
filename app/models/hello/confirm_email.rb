module Hello

  class ConfirmEmail
    include ActiveModel::Model

    attr_reader :credential

    def initialize(unencrypted_token=nil)
      if unencrypted_token
        find_credential(unencrypted_token)
      end
    end

    def confirm_email!
      credential.confirm_email!
    end

    def found_credential?
      !!credential
    end

    def message
      I18n.t("notice", scope: i18n_scope, email: credential.email)
    end

    def alert_message
      I18n.t("alert", scope: i18n_scope)
    end




    private

        # initialize helpers

        def find_credential(unencrypted_token)
          token_digest = Credential.encrypt_token(unencrypted_token)
          @credential  = Credential.classic.where(email_token_digest: token_digest).first
        end

        # helpers

        def i18n_scope
          'hello.messages.classic.registration.confirm_email'
        end

  end
end