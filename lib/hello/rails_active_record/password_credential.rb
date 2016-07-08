module Hello
  module RailsActiveRecord
    class PasswordCredential < ::Credential

      # VALIDATIONS
      validates_presence_of :password, on: :create
      validate :hello_validations, if: :digest_changed?

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
        return if errors.has_key?(:password)
        c = Hello.configuration
        validates_length_of :password, in: c.password_length
        return if errors.has_key?(:password)
        validates_format_of :password, with: c.password_regex
      end

    end
  end
end
