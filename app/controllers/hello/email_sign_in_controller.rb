module Hello
  class EmailSignInController < ApplicationController
    include Hello::Concerns::EmailSignInOnSuccess
    include Hello::Concerns::EmailSignInOnFailure

    kick :guest, only: [:authenticated]

    before_actions do
      only(:index, :authenticate) { @entity = @sign_in = SignInEntity.new }
    end

    # GET /hello/sign_in
    def index
      render_classic_sign_in
    end

    # POST /hello/sign_in
    def authenticate
      if @sign_in.authenticate(sign_in_params[:login], sign_in_params[:password])
        flash[:notice] = @sign_in.success_message
        on_success
      else
        on_failure
      end
    end

    private

    def sign_in_params
      params.require(:sign_in)
    end

    def render_classic_sign_in
      render 'hello/authentication/classic_sign_in/index'
    end
  end
end
