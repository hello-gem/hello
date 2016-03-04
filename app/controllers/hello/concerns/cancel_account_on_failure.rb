module Hello
  module Concerns
    module CancelAccountOnFailure

      def on_failure
        respond_to do |format|
          format.html { render_cancel_account }
          format.json { render json: { message: @cancel_account.alert_message }, status: :unprocessable_entity }
        end
      end

    end
  end
end
