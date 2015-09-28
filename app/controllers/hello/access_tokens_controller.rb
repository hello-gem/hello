require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class AccessTokensController < ApplicationController
    
    kick :guest, :onboarding
    
    before_actions do
      all            { sudo_mode }
      only(:index)   { @access_tokens = current_user.access_tokens }
      only(:destroy) { @access_token  = current_user.access_tokens.find(params[:id]) }
    end

    # GET /hello/access_tokens
    def index
    end

    # DELETE /hello/access_tokens/1
    def destroy
      entity = DestroyAccessTokenEntity.new
      if @access_token.destroy
        flash[:notice] = entity.success_message
      else
        flash[:alert]  = entity.alert_message
      end
      redirect_to access_tokens_url
    end

  end
end
