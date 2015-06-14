require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class Admin::ImpersonationController < ApplicationController

    restrict_unless_authenticated
    restrict_unless_role_is :admin, only: [:create]

    # POST /hello/admin/impersonate credential_id: 1
    def create
      user = User.find(params[:user_id])
      impersonate(user)

      entity = ImpersonateEntity.new(user)
      flash[:notice] = entity.success_message
      redirect_to :back
    end

    # GET /hello/admin/impersonate
    def destroy
      hello_back_to_myself

      entity = ImpersonateBackEntity.new
      flash[:notice] = entity.success_message
      redirect_to hello.homepage_path
    end

  end
end
