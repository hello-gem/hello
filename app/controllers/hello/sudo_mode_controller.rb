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
        flash[:notice] = t("hello.messages.common.sudo_mode.authenticate.notice")
        redirect_to path_to_go
      else
        flash.now[:alert] = t("hello.messages.common.sudo_mode.authenticate.alert")
        render :form
      end
    end

    # GET /hello/sudo_mode/expire
    def expire
      hello_session.update_attribute :sudo_expires_at, 1.second.ago
      flash[:notice] = t("hello.messages.common.sudo_mode.expire.notice")
      redirect_to root_path
    end

    private

        def credential_password_param
          params.require(:credential)[:password]
        end

  end
end
