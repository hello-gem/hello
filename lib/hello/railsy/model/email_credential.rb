module Hello
  module EmailCredential
    extend ActiveSupport::Concern

    included do
      validates_presence_of :email
      validates_email_format_of :email
      validates_uniqueness_of :email

      before_destroy :cannot_destroy_last_email_credential
    end

    module ClassMethods
    end

    #
    # downcase setters
    #

    def email=(v)
      super(v.to_s.downcase.delete(' '))
    end

    #
    # confirmation helpers
    #

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

    # private

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
