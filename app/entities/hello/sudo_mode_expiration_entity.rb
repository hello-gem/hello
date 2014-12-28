module Hello
  class SudoModeExpirationEntity < AbstractEntity

    attr_reader :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def expire!
      access_token.update! sudo_expires_at: 1.second.ago
    end
  end
end