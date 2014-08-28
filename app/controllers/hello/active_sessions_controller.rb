require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class ActiveSessionsController < ApplicationController
    
    before_actions do
      actions           { restrict_access_to_sudo_mode }
      actions(:index)   { @active_sessions = hello_user.active_sessions }
      actions(:destroy) { @active_session  = hello_user.active_sessions.find(params[:id]) }
    end

    # GET /hello/active_sessions
    def index
    end

    # DELETE /hello/active_sessions/1
    def destroy
      if @active_session.destroy
        flash[:notice] = t("hello.messages.common.active_sessions.destroy.notice")
      else
        flash[:alert] = t("hello.messages.common.active_sessions.destroy.alert") # TODO: write test for this message
      end
      redirect_to active_sessions_url
    end

  end
end
