module Hello
  class EmailSignUpController < ApplicationController

    dont_kick_people

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
      @errors = @sign_up.errors
      if @sign_up.save(params.require(:sign_up))
        @user       = @sign_up.user
        @credential = @sign_up.credential
        flash[:notice] = @sign_up.success_message
        success
      else
        failure
      end
    end

  end
end
