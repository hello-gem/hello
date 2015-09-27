# Learn more at config/initializers/hello.rb
#
module Hello
  module Extensions
    module Deactivation

      def deactivate!
        # current_user.update! deactivated_at: Time.now
        # current_user.update! deactivated: true
        current_user.destroy!
      rescue ActiveRecord::RecordNotDestroyed => invalid
        raise ActiveRecord::Rollback
      end

      def success
        respond_to do |format|
          format.html { redirect_to '/' }
          format.json { render json: {deactivated: true}, status: :ok }
        end
      end


    end
  end
end
