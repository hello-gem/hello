module Hello
  class SuperSignOutController < ApplicationController

    dont_kick_people

    # GET /hello/sign_out
    def sign_out
      destroy_and_clear_current_access_token

      @sign_out = SignOutEntity.new
      flash.now[:notice] = @sign_out.success_message
      
      success
    end
    
  end
end
