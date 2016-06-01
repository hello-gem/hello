module Hello
  module Business
    module Management
      class CancelAccount < Base

        def initialize(user)
          @user = user
        end

        def cancel_account
          @user.destroy!
        rescue ActiveRecord::RecordNotDestroyed => invalid
          false
        end

        def info_message
          t('info')
        end
      end
    end
  end
end
