module Hello
  class SudoModeAuthenticationEntity < AbstractEntity
    attr_reader :active_session

    def initialize(active_session)
      @active_session = active_session
    end

    def authenticate!(attrs)
      if active_session.credential.password_is?(attrs[:password])
        active_session.update! sudo_expires_at: 60.minutes.from_now
      end
    end

  end
end