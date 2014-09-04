require_dependency "hello/application_controller"

module Hello
  class DeactivationController < ApplicationController
    
    # GET /hello/deactivation
    def proposal
    end

    # POST /hello/deactivation
    def deactivate
      # TODO: expose it's implementation to end-developer and find a way to test an error case
      array = [hello_user] + hello_user.credentials + hello_user.active_sessions
      User.transaction { array.map(&:destroy!) }

      entity = DeactivateEntity.new
      flash[:notice] = entity.success_message
      redirect_to hello.after_deactivation_path
    end

    # GET /hello/deactivation/after_deactivate
    def after_deactivate
    end

  end
end
