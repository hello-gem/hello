module Hello
  module Token
    # probability = 1 / ((8*2) ** (8*2))
    def self.single(complexity=8)
      SecureRandom.hex(complexity)
    end

    def self.pair
      s = single
      [s, encrypt(s)]
    end

    def self.encrypt(s)
      Digest::MD5.hexdigest(s)
    end

    def self.match(string, token)
      encrypt(string) == token
    end
  end
end
