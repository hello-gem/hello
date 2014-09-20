module Hello
  class SudoModeExpirationEntity < AbstractEntity

    attr_reader :active_session

    def initialize(active_session)
      @active_session = active_session
    end

    def expire!
      active_session.update! sudo_expires_at: 1.second.ago
    end
  end
end