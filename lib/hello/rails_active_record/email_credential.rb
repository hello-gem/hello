module Hello
  module RailsActiveRecord
    class EmailCredential < ::Credential

      # VALIDATIONS
      validates_uniqueness_of :email
      validates_presence_of :email
      validate :hello_validations, if: :email?

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
        return if errors.has_key?(:email)

        c = Hello.configuration
        validates_length_of :email, in: c.email_length
        validates_format_of :email, with: c.email_regex
      end


    end
  end
end
