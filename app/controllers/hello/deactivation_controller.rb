module Hello
  class DeactivationController < SuperDeactivationController
    
    def perform_deactivation
      # current_user.update! deactivated_at: Time.now
      # current_user.update! deactivated: true
      current_user.destroy!
    rescue ActiveRecord::RecordNotDestroyed => invalid
      raise ActiveRecord::Rollback
    end

    def success
      respond_to do |format|
        format.html { redirect_to hello.deactivated_path }
        format.json { render json: {deactivated: true}, status: :ok }
      end
    end

  end
end
