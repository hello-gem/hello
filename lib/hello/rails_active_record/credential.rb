module Hello
  module RailsActiveRecord
    class Credential < ::ActiveRecord::Base
      self.table_name = 'credentials'

      # ASSOCIATIONS
      belongs_to :user, counter_cache: true, class_name: '::User'

      # VALIDATIONS
      validates_presence_of :user, :type
      validates_inclusion_of :type, in: %w(EmailCredential PasswordCredential)

      # CUSTOM METHODS

      # def is_email?
      #   is_a?(EmailCredential)
      # end

      def first_error_message
        errors.messages.values.flatten.first if errors.any?
      end

      # verifying token

      def verifying_token_is?(unencrypted_token)
        digest = simple_encryptor.encrypt(unencrypted_token)
        verifying_token_digest == digest
      end

      def reset_verifying_token!
        uuid, digest = simple_encryptor.pair
        update!(verifying_token_digest: digest, verifying_token_digested_at: 1.second.ago)
        uuid
      end

      def invalidate_verifying_token!
        update(verifying_token_digest: nil, verifying_token_digested_at: nil)
      end

      private

      def hello_is_user_being_destroyed?
        !!Thread.current['Hello.destroying_user']
      end

      def simple_encryptor
        Hello.configuration.simple_encryptor
      end
    end
  end
end
