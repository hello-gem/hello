# Learn more at config/initializers/hello.rb
#
module Hello
  module Extensions
    module CancelAccount

      def success
        respond_to do |format|
          format.html { redirect_to '/' }
          format.json { render json: {cancelled: true}, status: :ok }
        end
      end

      def failure
        respond_to do |format|
          format.html { render action: 'index' }
          format.json { render json: {message: @cancel_account.alert_message }, status: :unprocessable_entity }
        end
      end

    end
  end
end
