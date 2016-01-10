module Hello
  class SudoModeAuthenticationEntity < AbstractEntity
    attr_reader :access

    def initialize(access)
      @access = access
    end

    def authenticate!(password, sudo_expires_at)
      if access.user.password_is?(password)
        access.update! sudo_expires_at: sudo_expires_at
      end
    end
  end
end
