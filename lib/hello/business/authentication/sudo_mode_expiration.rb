module Hello
  module Business
    module Authentication
      class SudoModeExpiration < Base
        attr_reader :access

        def initialize(access)
          @access = access
        end

        def expire!
          access.update! sudo_expires_at: 1.second.ago
        end
      end
    end
  end
end
