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
      entity = SudoModeAuthenticationEntity.new

      if hello_credential.password_is?(credential_password_param)
        hello_active_session.update_attribute :sudo_expires_at, 60.minutes.from_now
        path_to_go = session[:hello_url] || root_path
        flash[:notice] = entity.success_message
        redirect_to path_to_go
      else
        flash.now[:alert] = entity.alert_message
        render :form
      end
    end

    # GET /hello/sudo_mode/expire
    def expire
      hello_active_session.update_attribute :sudo_expires_at, 1.second.ago
      entity = SudoModeExpirationEntity.new
      flash[:notice] = entity.success_message
      redirect_to root_path
    end

    private

        def credential_password_param
          params.require(:credential)[:password]
        end

  end
end
