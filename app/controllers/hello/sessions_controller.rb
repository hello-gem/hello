require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class SessionsController < ApplicationController
    
    before_actions do
      actions           { restrict_access_to_sudo_mode }
      actions(:index)   { @sessions = hello_user.sessions }
      actions(:destroy) { @session  = hello_user.sessions.find(params[:id]) }
    end

    # GET /hello/sessions
    def index
    end

    # DELETE /hello/sessions/1
    def destroy
      if @session.destroy
        flash[:notice] = t("hello.messages.common.sessions.destroy.notice")
      else
        flash[:alert] = t("hello.messages.common.sessions.destroy.alert") # TODO: write test for this message
      end
      redirect_to sessions_url
    end

  end
end
