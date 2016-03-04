module Hello
  class SudoModeAuthenticationEntity < AbstractEntity
    attr_reader :access

    def initialize(access)
      @access = access
    end

    def authenticate!(password)
      if access.user.password_is?(password)
        access.update!(sudo_expires_at: sudo_expires_at)
      end
    end

    private

    def sudo_expires_at
      Hello.configuration.sudo_expires_in.from_now
    end
  end
end
