require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class SessionsController < ApplicationController
    restrict_access_to_sudo_mode
    
    before_actions do
      actions(:index)   { @sessions = hello_user.sessions }
      actions(:show)    { @session  = hello_user.sessions.find(params[:id]) }
    end

    # GET /hello/sessions
    def index
    end

    # GET /hello/sessions/1
    def show
      if @session.destroy
        flash[:notice] = t("hello.messages.common.sessions.destroy.notice")
      else
        flash[:alert] = t("hello.messages.common.sessions.destroy.alert") # TODO: write test for this message
      end
      redirect_to sessions_url
    end

  end
end
