module Hello
  class EmailSignUpController < ApplicationController
    include Hello::Concerns::EmailSignUpOnSuccess
    include Hello::Concerns::EmailSignUpOnFailure

    dont_kick_people

    before_action do
      @entity = @sign_up = SignUpEntity.new
    end

    # GET /hello/sign_up
    def index
      render_classic_sign_up
    end

    # GET /hello/sign_up/widget
    def widget
      render 'hello/registration/classic_sign_up/widget', layout: false
    end

    # POST /hello/sign_up
    def create
      if @sign_up.register(params.require(:sign_up))
        flash[:notice] = @sign_up.success_message
        on_success
      else
        on_failure
      end
    end

    def render_classic_sign_up
      render 'hello/registration/classic_sign_up/index'
    end
  end
end
