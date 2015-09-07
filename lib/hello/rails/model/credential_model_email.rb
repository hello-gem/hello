module Hello
  module CredentialModelEmail
    extend ActiveSupport::Concern


    included do
      validates_presence_of     :email, if: :is_classic?
      validates_email_format_of :email, if: :is_classic?
      validates_uniqueness_of   :email, if: :is_classic?
    end

    module ClassMethods
    end

    #
    # downcase setters
    #

    def email=(v)
      v = v.to_s.downcase.gsub(' ', '')
      write_attribute(:email, v)
    end

    #
    # confirmation helpers
    #

    def email_confirmed?
      !!email_confirmed_at
    end

    def email_delivered?
      !!email_delivered_at
    end

    def email_delivered_at
      email_token_digested_at
    end

    def reset_email_token!
      uuid, digest = Token.pair
      update!(email_token_digest: digest, email_token_digested_at: 1.second.ago)
      return uuid
    end

    def confirm_email!
      update! email_token_digest: nil, email_token_digested_at: nil, email_confirmed_at: 1.second.ago
    end

  end
end