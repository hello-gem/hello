module Hello
  module UserModelPassword
      extend ActiveSupport::Concern


      included do
        attr_reader :password
        validates_presence_of :password, on: :create
        validates_length_of :password,
                            in: 4..200,
                            too_long:  'maximum of %{count} characters',
                            too_short: 'minimum of %{count} characters',
                            if: :password_digest_changed?
      end

      module ClassMethods
      end

      def password=(value)
        # puts "password=('#{value}')".blue
        if value.blank?
          self.password_digest = @password = nil
        end
        value = value.to_s.gsub(' ', '')
        @password = value
        self.password_digest = encrypt_password(value)
      end

      # we recommend programmers to override this method in their apps
      def encrypt_password(plain_text_password)
        # puts "encrypt_password('#{plain_text_password}')".blue
        BCrypt::Password.create(plain_text_password)
      end

      # we recommend programmers to override this method in their apps
      def password_is?(plain_text_password)
        # puts "password_is?('#{plain_text_password}')".blue
        bc_password = BCrypt::Password.new(password_digest)
        bc_password == plain_text_password 
      rescue BCrypt::Errors::InvalidHash
        false
      end



      def reset_password_token
        uuid = SecureRandom.hex(8) # probability = 1 / (16 ** 16)
        digest = Hello.encrypt_token(uuid)
        update(password_token_digest: digest, password_token_digested_at: 1.second.ago)
        return uuid
      end

      def invalidate_password_token
        update(password_token_digest: nil, password_token_digested_at: nil)
      end





  end
end