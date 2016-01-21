module Hello
  module Concerns
    module CancelAccountOnSuccess

      def on_success
        respond_to do |format|
          format.html { redirect_to '/' }
          format.json { render json: { cancelled: true }, status: :ok }
        end
      end

    end
  end
end
