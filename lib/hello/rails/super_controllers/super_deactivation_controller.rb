module Hello
  class SuperDeactivationController < ApplicationController
    
    restrict_unless_authenticated except: [:deactivated]
    restrict_if_authenticated     only:   [:deactivated]

    before_actions do
      only(:proposal, :deactivate) { @deactivation = DeactivateEntity.new }
    end

    # GET /hello/deactivation
    def proposal
    end

        # POST /hello/deactivation
        def deactivate
          has_deactivated = false
          User.transaction { has_deactivated = perform_deactivation }

          if has_deactivated
            flash[:notice] = @deactivation.success_message
            success
          else
            flash.now[:alert] = @deactivation.alert_message
            render :proposal
            # respond_to do |format|
            #   format.html {  }
            #   format.json { render json: {message: @deactivation.alert_message }, status: :unprocessable_entity }
            # end
          end
        end

            # GET /hello/deactivation/deactivated
            def deactivated
            end

  end    
end
