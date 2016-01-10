module Hello
  class SudoModeExpirationEntity < AbstractEntity
    attr_reader :access

    def initialize(access)
      @access = access
    end

    def expire!
      access.update! sudo_expires_at: 1.second.ago
    end
  end
end
