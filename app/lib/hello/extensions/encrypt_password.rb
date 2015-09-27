# Learn more at config/initializers/hello.rb
#
module Hello
  module Extensions
    module EncryptPassword

      def self.encrypt(plain_text)
        BCrypt::Password.create(plain_text)
      end

      def self.check(user, plain_text)
        BCrypt::Password.new(user.password_digest) == plain_text 
      rescue BCrypt::Errors::InvalidHash
        false
      end

    end
  end
end
