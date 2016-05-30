module Hello
  module Concerns
    module Management
      module ResetPassword

        def on_success
          access_token = sign_in!(@reset_password.user, expires_at, sudo_mode_expires_at)

          redirect_to path_to_go
        end

        def on_failure
          render_reset_form
        end

        private

        def expires_at
          30.days.from_now
        end

        def sudo_mode_expires_at
          Hello.configuration.sudo_expires_in.from_now
        end

        def path_to_go
          '/'
        end

      end
    end
  end
end
