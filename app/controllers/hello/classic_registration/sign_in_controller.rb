require_dependency "hello/application_controller"

module Hello
module ClassicRegistration
  class SignInController < ApplicationController

    restrict_if_authenticated     except: [:authenticated]
    restrict_unless_authenticated only:   [:authenticated]

    # GET /hello/sign_in
    def index
      @sign_in = SignInEntity.new
    end

    # POST /hello/sign_in
    def authenticate
      @sign_in = SignInEntity.new(params.require(:sign_in))
      @user = @sign_in.user

      control = SignInControl.new(self, @sign_in)

      if @sign_in.authenticate
        flash[:notice] = @sign_in.success_message
        control.success
      else
        control.failure
      end
    end

    # GET /hello/authenticated
    def authenticated
    end




  end
end
end
