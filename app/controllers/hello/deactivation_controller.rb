require_dependency "hello/application_controller"

module Hello
  class DeactivationController < ApplicationController
    
    restrict_unless_authenticated except: [:done]
    restrict_if_authenticated     only:   [:done]

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

            # GET /hello/deactivation/done
            def done
            end

  end
end
