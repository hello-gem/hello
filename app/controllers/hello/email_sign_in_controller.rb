module Hello
  class EmailSignInController < ApplicationController
    kick :guest, only: [:authenticated]

    before_actions do
      only(:index, :authenticate) { @entity = @sign_in = SignInEntity.new }
    end

    # GET /hello/sign_in
    def index
    end

    # POST /hello/sign_in
    def authenticate
      if @sign_in.authenticate(sign_in_params[:login], sign_in_params[:password])
        flash[:notice] = @sign_in.success_message
        success
      else
        failure
      end
    end

    private

    def sign_in_params
      params.require(:sign_in)
    end
  end
end
