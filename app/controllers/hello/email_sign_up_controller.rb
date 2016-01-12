module Hello
  class EmailSignUpController < ApplicationController
    dont_kick_people

    before_action do
      @entity = @sign_up = SignUpEntity.new
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
      if @sign_up.register(params.require(:sign_up))
        flash[:notice] = @sign_up.success_message
        success
      else
        failure
      end
    end
  end
end
