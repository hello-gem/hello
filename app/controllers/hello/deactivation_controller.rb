require_dependency "hello/application_controller"

module Hello
  class DeactivationController < ApplicationController
    
    restrict_unless_authenticated except: [:after_deactivate]
    restrict_if_authenticated     only:   [:after_deactivate]

    before_actions do
      only(:proposal, :deactivate) { @deactivation = DeactivateEntity.new }
    end

    # GET /hello/deactivation
    def proposal
    end

        # POST /hello/deactivation
        def deactivate
          control = DeactivationControl.new(self, @deactivation)

          has_deactivated = false
          User.transaction { has_deactivated = control.deactivate }

          if has_deactivated
            flash[:notice] = @deactivation.success_message
            control.success
          else
            flash.now[:alert] = @deactivation.alert_message
            render :proposal
            # respond_to do |format|
            #   format.html {  }
            #   format.json { render json: {message: @deactivation.alert_message }, status: :unprocessable_entity }
            # end
          end
        end

            # GET /hello/deactivation/after_deactivate
            def after_deactivate
            end

  end
end
