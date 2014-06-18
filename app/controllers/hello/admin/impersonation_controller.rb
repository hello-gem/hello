require_dependency "hello/application_controller"

module Hello
  class Admin::ImpersonationController < ApplicationController

    # POST /hello/admin/impersonate credential_id: 1
    def create
      credential = Credential.find(params[:credential_id])
      hello_impersonate(credential)
      redirect_to :back, notice: "You are now #{credential.user.name}"
    end

    # GET /hello/admin/impersonate
    def destroy
      hello_back_to_myself
      redirect_to :back, notice: "You are yourself again"
    end

  end
end
