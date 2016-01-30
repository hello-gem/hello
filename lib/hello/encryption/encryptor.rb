module Hello
  module Encryption
    class Encryptor
      def encrypt(string)
        BCrypt::Password.create(string)
      end

      def match(string, digest)
        BCrypt::Password.new(digest) == string
      rescue BCrypt::Errors::InvalidHash
        false
      end
    end
  end
end
