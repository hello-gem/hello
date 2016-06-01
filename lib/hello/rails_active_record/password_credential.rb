module Hello
  module RailsActiveRecord
    class PasswordCredential < ::Credential

      # VALIDATIONS
      validates_presence_of :password, on: :create
      # validates_presence_of :digest

      # before_destroy :cannot_destroy_last_password_credential
      validate :hello_validations

      # SETTERS

      attr_reader :password

      def password=(value)
        # puts "password=('#{value}')".blue
        self.digest = @password = nil if value.blank?
        @password = value

        self.digest = complex_encryptor.encrypt(value)
      end

      # CUSTOM METHODS

      def password_is?(plain_text_password)
        complex_encryptor.match(plain_text_password, digest)
      end

      def set_generated_password
        self.password = simple_encryptor.single(4) # 8 chars
      end

      private

      def hello_validations
        return true unless digest_changed?

        return false if errors[:password].any?
        c = Hello.configuration

        validates_length_of :password, in: c.password_length
        return false if errors[:password].any?

        validates_format_of :password, with: c.password_regex
        return false if errors[:password].any?
      end

      def complex_encryptor
        Hello::Encryptors::Complex.instance
      end

      def simple_encryptor
        Hello::Encryptors::Simple.instance
      end

      # # TODO: code for multiple passwords
      # def cannot_destroy_last_password_credential
      #   return if hello_is_user_being_destroyed?
      #   return if not is_last_password_credential?
      #   errors[:base] << "must have at least one credential"
      #   false
      # end

      # def is_last_password_credential?
      #   user.password_credentials.count == 1
      # end
    end
  end
end
