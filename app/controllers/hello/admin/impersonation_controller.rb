require_dependency "hello/application_controller"

module Hello
  class Admin::ImpersonationController < ApplicationController

    # POST /hello/admin/impersonate credential_id: 1
    def create
      credential = Credential.find(params[:credential_id])
      hello_impersonate(credential)

      entity = ImpersonateEntity.new(credential)
      flash[:notice] = entity.success_message
      redirect_to :back
    end

    # GET /hello/admin/impersonate
    def destroy
      hello_back_to_myself

      entity = ImpersonateBackEntity.new
      flash[:notice] = entity.success_message
      redirect_to :back
    end

  end
end
