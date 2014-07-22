require_dependency "hello/application_controller"

module Hello
  class Admin::ImpersonationController < ApplicationController

    # POST /hello/admin/impersonate credential_id: 1
    def create
      credential = Credential.find(params[:credential_id])
      hello_impersonate(credential)
      flash[:notice] = t("hello.messages.admin.impersonation.create.notice", name: credential.user.name)
      redirect_to :back
    end

    # GET /hello/admin/impersonate
    def destroy
      hello_back_to_myself
      flash[:notice] = t("hello.messages.admin.impersonation.destroy.notice")
      redirect_to :back
    end

  end
end
