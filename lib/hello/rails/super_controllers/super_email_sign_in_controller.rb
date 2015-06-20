module Hello
  class SuperEmailSignInController < ApplicationController

    dont_kick :guest, only: [:index, :authenticate]
    kick      :guest, only: [:authenticated]

    # GET /hello/sign_in
    def index
      @entity = @sign_in = SignInEntity.new
    end

    # POST /hello/sign_in
    def authenticate
      @entity = @sign_in = SignInEntity.new(params.require(:sign_in))
      @user = @sign_in.user

      if @sign_in.authenticate
        flash[:notice] = @sign_in.success_message
        success
      else
        failure
      end
    end

    # GET /hello/authenticated
    def authenticated
    end




  end
end
