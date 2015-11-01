module Hello
  module Credential
    module Core
      extend ActiveSupport::Concern

      included do
        belongs_to :user, counter_cache: true
        validates_presence_of :user

        validates_presence_of :type
        validates_inclusion_of :type, in: %w(EmailCredential PasswordCredential)
      end


      module ClassMethods
      end

      # def is_email?
      #   is_a?(EmailCredential)
      # end

      def first_error_message
        errors.messages.values.flatten.first if errors.any?
      end




      # verifying token

      def verifying_token_is?(unencrypted_token)
        digest = Token.encrypt(unencrypted_token)
        verifying_token_digest == digest
      end

      def reset_verifying_token!
        uuid, digest = Token.pair
        update!(verifying_token_digest: digest, verifying_token_digested_at: 1.second.ago)
        return uuid
      end

      def invalidate_verifying_token!
        update(verifying_token_digest: nil, verifying_token_digested_at: nil)
      end



      private

      def hello_is_user_being_destroyed?
        !!Thread.current["Hello.destroying_user"]
      end

    end
  end
end
