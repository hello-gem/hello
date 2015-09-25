module Hello
  class DeactivationController < ApplicationController
    
    kick      :guest, only: [:index, :deactivate]
    dont_kick :guest, only: [:deactivated]

    before_actions do
      only(:index, :deactivate) { @deactivation = DeactivateEntity.new }
    end

    # GET /hello/deactivation
    def index
    end

        # POST /hello/deactivation
        def deactivate
          has_deactivated = false
          User.transaction { has_deactivated = deactivate! }

          if has_deactivated
            flash[:notice] = @deactivation.success_message
            success
          else
            flash.now[:alert] = @deactivation.alert_message
            render :index
            # respond_to do |format|
            #   format.html {  }
            #   format.json { render json: {message: @deactivation.alert_message }, status: :unprocessable_entity }
            # end
          end
        end

  end
end
