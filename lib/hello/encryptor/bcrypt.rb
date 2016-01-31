module Hello
  module Encryptor
    class BCrypt < MD5
      def initialize
        require 'bcrypt'
      rescue LoadError
        s = "your Gemfile needs: gem 'bcrypt'"
        puts [s.red, s.yellow, s.green]
        raise
      end

      def encrypt(string)
        ::BCrypt::Password.create(string).to_s
      end

      def match(string, digest)
        ::BCrypt::Password.new(digest) == string
      rescue ::BCrypt::Errors::InvalidHash
        false
      end
    end
  end
end
