module Hello
  module Business
    module Authentication
      class SudoModeExpiration < Base
        attr_reader :access

        def initialize(access)
          @access = access
        end

        def expire!
          access.sudo_expire!
        end
      end
    end
  end
end
