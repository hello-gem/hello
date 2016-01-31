module Hello
  module Encryptor
    class MD5
      # probability = 1 / ((8*2) ** (8*2))
      def single(complexity = 8)
        SecureRandom.hex(complexity)
      end

      def pair(complexity = 8)
        s = single(complexity)
        [s, encrypt(s)]
      end

      def encrypt(s)
        Digest::MD5.hexdigest(s)
      end

      def match(string, token)
        encrypt(string) == token
      end
    end
  end
end
