module Hello
  module Concerns
    module Authentication
      module SignIn

        def on_success
          access_token = sign_in!(@sign_in.user, expires_at, sudo_mode_expires_at)

          respond_to do |format|
            format.html { redirect_to path_to_go }
            format.json { render json: access_token.as_json_web_api, status: :created }
          end
        end

        def on_failure
          respond_to do |format|
            format.html { render_sign_in }
            format.json { render json: @sign_in.errors, status: :unprocessable_entity }
          end
        end


        private

        def expires_at
          if params[:keep_me]
            30.days.from_now
          else
            30.minutes.from_now
          end
        end

        def sudo_mode_expires_at
          Hello.configuration.sudo_expires_in.from_now
        end

        def path_to_go
          session.delete(:url) || '/'
        end

      end
    end
  end
end
