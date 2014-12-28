module Hello
  class SudoModeAuthenticationEntity < AbstractEntity
    attr_reader :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def authenticate!(attrs)
      if access_token.credential.password_is?(attrs[:password])
        access_token.update! sudo_expires_at: 60.minutes.from_now
      end
    end

  end
end