module Hello
  module RailsActiveRecord
    module Credential
      extend ActiveSupport::Concern

      included do

        # ASSOCIATIONS
        belongs_to :user, validate: true, counter_cache: true

        # VALIDATIONS
        # validates_presence_of :user
        before_save do
          if user.nil?
            self.errors.add_on_blank([:user])
            fail ActiveRecord::Rollback
          end
        end

        after_destroy do
          if destroyed_by_association.nil?
            if user.invalid?
              user.errors.each { |k, v| errors.add(k, v) if k.to_s.include?('credentials')}
              fail ActiveRecord::Rollback
            end
          end
        end
      end

      # CUSTOM METHODS

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

      protected

      def complex_encryptor
        Hello::Encryptors::Complex.instance
      end

      def simple_encryptor
        Hello::Encryptors::Simple.instance
      end

    end
  end
end
