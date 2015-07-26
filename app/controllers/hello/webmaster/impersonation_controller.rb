require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class Webmaster::ImpersonationController < ApplicationController

    dont_kick :webmaster, only: [:create]

    # POST /hello/webmaster/impersonate user_id: 1
    def create
      user = User.find(params[:user_id])
      impersonate(user)

      entity = ImpersonateEntity.new(user)
      flash[:notice] = entity.success_message
      redirect_to :back
    end

    # GET /hello/webmaster/impersonate
    def destroy
      hello_back_to_myself

      entity = ImpersonateBackEntity.new
      flash[:notice] = entity.success_message
      redirect_to hello.webmaster_path
    end

  end
end
