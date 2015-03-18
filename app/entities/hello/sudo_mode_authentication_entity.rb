module Hello
  class SudoModeAuthenticationEntity < AbstractEntity
    attr_reader :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def authenticate!(password, sudo_expires_at)
      if access_token.user.password_is?(password)
        access_token.update! sudo_expires_at: sudo_expires_at
      end
    end

  end
end