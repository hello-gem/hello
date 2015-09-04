module Hello
  class SignOutController < ApplicationController

    dont_kick_people

    # GET /hello/sign_out
    def sign_out
      sign_out!

      @sign_out = SignOutEntity.new
      flash.now[:notice] = @sign_out.success_message
      
      success
    end

  end
end
