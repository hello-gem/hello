require_dependency 'hello/application_controller'

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class AccessesController < ApplicationController
    kick :guest, :onboarding

    before_actions do
      all            { sudo_mode }
      only(:index)   { @accesses = current_user.accesses }
      only(:destroy) { @access = current_user.accesses.find(params[:id]) }
    end

    # GET /hello/accesses
    def index
      render 'hello/management/accesses/index'
    end

    # DELETE /hello/accesses/1
    def destroy
      entity = UnlinkAccessEntity.new
      if @access.destroy
        flash[:notice] = entity.success_message
      else
        flash[:alert]  = entity.alert_message
      end
      redirect_to hello.accesses_url
    end
  end
end
