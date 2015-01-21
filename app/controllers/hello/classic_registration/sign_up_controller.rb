require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
module ClassicRegistration
  class SignUpController < ApplicationController

    restrict_if_authenticated

    # GET /hello/sign_up
    def index
      @sign_up = SignUpEntity.new(self)
    end

    # POST /hello/sign_up
    def create
      @sign_up = SignUpEntity.new(self)

      control = SignUpControl.new(self, @sign_up)

      if @sign_up.save(params.require(:sign_up))
        @credential = @sign_up.credential
        @password   = @sign_up.password
        flash[:notice] = @sign_up.success_message
        control.success
      else
        control.failure
      end
    end



  end
end
end