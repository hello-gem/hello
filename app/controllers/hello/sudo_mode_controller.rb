require_dependency "hello/application_controller"

module Hello
  class SudoModeController < ApplicationController

    # GET /hello/sudo_mode
    def form
    end

    # PATCH /hello/sudo_mode
    def authenticate
      if hello_credential.password_is?(credential_password_param)
        hello_session.update_attribute :sudo_expires_at, 60.minutes.from_now
        path_to_go = session[:hello_url] || root_path
        redirect_to path_to_go, notice: "Now we know it's really you. We won't be asking your password again for 60 minutes"
      else
        flash.now[:alert] = "Incorrect Password"
        render :form
      end
    end

    # GET /hello/sudo_mode/expire
    def expire
      hello_session.update_attribute :sudo_expires_at, 1.second.ago
      redirect_to root_path, notice: "We will now ask your password for sensitive access"
    end

    private

        def credential_password_param
          params.require(:credential)[:password]
        end

  end
end
