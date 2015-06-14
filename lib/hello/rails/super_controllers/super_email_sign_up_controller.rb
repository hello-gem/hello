module Hello
  class SuperEmailSignUpController < ApplicationController

    restrict_if_authenticated

    before_action do
      @entity = @sign_up = SignUpEntity.new(self)
    end

    # GET /hello/sign_up
    def index
    end

    # GET /hello/sign_up/widget
    def widget
      render layout: false
    end

    # POST /hello/sign_up
    def create
      if @sign_up.save(params.require(:sign_up))
        @credential = @sign_up.credential
        @password   = @sign_up.password
        flash[:notice] = @sign_up.success_message
        success
      else
        failure
      end
    end

  end
end
