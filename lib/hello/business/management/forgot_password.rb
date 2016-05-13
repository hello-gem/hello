module Hello
  module Business
    module Management
      class ForgotPassword < Base
        attr_accessor :login
        attr_reader :user

        def initialize(attrs = nil)
          if attrs
            @login = attrs[:login]
            @user = find_user
          end
        end

        def reset
          if user.present?
            true
          else
            errors.add(:login, 'was not found')
            false
          end
        end

        def email?
          login.to_s.include? '@'
        end

        def success_message(_extra = {})
          super(login: @login)
        end

        private

        # initialize helpers

        def find_user
          if email?
            credential = ::EmailCredential.find_by_email(login)
            credential.user
          else
            ::User.where(username: login).first
          end
        end
      end
    end
  end
end
