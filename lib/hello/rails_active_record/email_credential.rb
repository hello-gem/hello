module Hello
  module RailsActiveRecord
    class EmailCredential < ::Credential

      # VALIDATIONS
      before_destroy :cannot_destroy_last_email_credential

      validate :hello_validations
      validates_uniqueness_of :email

      # SETTERS
      def email=(v)
        super(v.to_s.downcase.delete(' '))
      end

      # CUSTOM METHODS

      def email_confirmed?
        !!confirmed_at
      end

      def email_delivered?
        !!email_delivered_at
      end

      def email_delivered_at
        verifying_token_digested_at
      end

      def confirm_email!
        update! verifying_token_digest: nil, verifying_token_digested_at: nil, confirmed_at: 1.second.ago
      end

      private

      def hello_validations
        validates_presence_of :email
        return false if errors[:email].any?

        c = Hello.configuration
        validates_length_of :email, in: c.email_length
        return false if errors[:email].any?

        validates_format_of :email, with: c.email_regex
        return false if errors[:email].any?
      end

      def cannot_destroy_last_email_credential
        return if hello_is_user_being_destroyed?
        return unless is_last_email_credential?
        errors[:base] << 'must have at least one credential'
        false
      end

      def is_last_email_credential?
        user.email_credentials.count == 1
      end
    end
  end
end
