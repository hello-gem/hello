module Hello
  module Encryption
    class Encryptor
      def encrypt(string)
        BCrypt::Password.create(string).to_s
      end

      def match(string, digest)
        BCrypt::Password.new(digest) == string
      rescue BCrypt::Errors::InvalidHash
        false
      end
    end
  end
end
