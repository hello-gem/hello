require_dependency 'hello/application_controller'

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class SudoModeController < ApplicationController
    kick :guest, :onboarding

    # GET /hello/sudo_mode
    def form
      render_sudo_mode_form
    end

    # PATCH /hello/sudo_mode
    def authenticate
      entity = SudoModeAuthenticationEntity.new(current_access)

      if entity.authenticate!(password_param)
        path_to_go = session[:url] || root_path
        flash[:notice] = entity.success_message
        redirect_to path_to_go
      else
        flash.now[:alert] = entity.alert_message
        render_sudo_mode_form
      end
    end

    # GET /hello/sudo_mode/expire
    def expire
      entity = SudoModeExpirationEntity.new(current_access)
      entity.expire!
      flash[:notice] = entity.success_message
      redirect_to '/'
    end

    private

    def password_param
      params.require(:user)[:password]
    end
  end
end
