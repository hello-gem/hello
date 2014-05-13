require_dependency "hello/application_controller"

module Hello
  class SessionsController < ApplicationController
    restrict_access_to_sudo_mode
    
    before_actions do
      actions(:index)   { @sessions = hello_user.sessions }
      actions(:show)  {
        @session = hello_user.sessions.find(params[:id])
      }
    end

    # GET /hello/sessions
    def index
    end

    # GET /hello/sessions/1
    def show
      if @session.destroy
        flash[:notice] = "Device has been disconnected from your account"
      else
        flash[:alert] = "There was an error while unlogging you"
      end
      redirect_to sessions_url
    end

  end
end
