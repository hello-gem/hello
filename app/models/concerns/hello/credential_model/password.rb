module Hello
  module CredentialModel
    module Password
      extend ActiveSupport::Concern


      def password=(value)
        if value.blank?
          @password_digest = @password = nil
        end
        @password = value
        self.password_digest = encrypt_password(value)
      end


      included do
        attr_reader :password

        validates_presence_of :email,    if: :is_classic?
        validates_presence_of :password, if: :is_classic?, on: :create

        # email
        validates_email_format_of :email, if: :is_classic?
        validates_uniqueness_of :email,
                                message: 'already exists',
                                if: :is_classic?

        # password
        validates_length_of :password,
                            in: 4..200,
                            too_long:  'maximum of %{count} characters',
                            too_short: 'minimum of %{count} characters',
                            if: :is_classic_and_password_changed?
      end


      def is_classic?
        strategy.to_s.inquiry.classic?
      end

      def is_classic_and_password_changed?
        is_classic? && password_digest_changed?
      end



      module ClassMethods
        def encrypt_token(plain_text_string)
          Digest::MD5.hexdigest(plain_text_string)
        end
      end

      def reset_password_token
        uuid = SecureRandom.hex(8) # probability = 1 / (16 ** 16)
        digest = self.class.encrypt_token(uuid)
        update(password_token_digest: digest, password_token_digested_at: 1.second.ago)
        return uuid
      end

      def invalidate_password_token
        update(password_token_digest: nil, password_token_digested_at: nil)
      end


      private







    end
  end
end