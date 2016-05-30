module Hello
  module Management
    class AccessesController < ApplicationController
      kick :guest, :onboarding

      before_actions do
        all            { sudo_mode }
        only(:index)   { @accesses = current_user.accesses }
        only(:destroy) { @access = current_user.accesses.find(params[:id]) }
      end

      # GET /hello/accesses
      def index
        render 'hello/management/accesses'
      end

      # DELETE /hello/accesses/1
      def destroy
        business = Business::Management::UnlinkAccess.new
        if @access.destroy
          flash[:notice] = business.success_message
        else
          flash[:alert]  = business.alert_message
        end
        redirect_to hello.accesses_url
      end
    end
  end
end
