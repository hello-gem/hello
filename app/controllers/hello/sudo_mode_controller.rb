require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class SudoModeController < ApplicationController

    restrict_to_users
    
    # GET /hello/sudo_mode
    def form
    end

    # PATCH /hello/sudo_mode
    def authenticate
      entity = SudoModeAuthenticationEntity.new(hello_active_session)

      if entity.authenticate!(params.require(:credential))
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
      entity = SudoModeExpirationEntity.new(hello_active_session)
      entity.expire!
      flash[:notice] = entity.success_message
      redirect_to hello.homepage_path
    end

  end
end
