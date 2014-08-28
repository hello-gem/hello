require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class SudoModeController < ApplicationController

    # GET /hello/sudo_mode
    def form
    end

    # PATCH /hello/sudo_mode
    def authenticate
      if hello_credential.password_is?(credential_password_param)
        hello_active_session.update_attribute :sudo_expires_at, 60.minutes.from_now
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
      hello_active_session.update_attribute :sudo_expires_at, 1.second.ago
      flash[:notice] = t("hello.messages.common.sudo_mode.expire.notice")
      redirect_to root_path
    end

    private

        def credential_password_param
          params.require(:credential)[:password]
        end

  end
end
