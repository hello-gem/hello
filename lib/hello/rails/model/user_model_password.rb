module Hello
  module UserModelPassword
      extend ActiveSupport::Concern


      included do
        attr_reader :password
        validates_presence_of :password, on: :create

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
        
        self.password_digest = password_encryption_module.encrypt(value)
      end

      def password_is?(plain_text_password)
        password_encryption_module.check(self, plain_text_password)
      end

      def password_encryption_module
        Hello.configuration.modules.encrypt_password
      end




      def reset_password_token
        uuid, digest = Token.pair
        update(password_token_digest: digest, password_token_digested_at: 1.second.ago)
        return uuid
      end

      def invalidate_password_token
        update(password_token_digest: nil, password_token_digested_at: nil)
      end





  end
end