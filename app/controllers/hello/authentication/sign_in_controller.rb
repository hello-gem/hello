module Hello
  module Authentication
    # you really should be overriding concerns instead of this file
    class SignInController < ApplicationController
      include Hello::Concerns::Authentication::SignIn

      kick :guest, only: [:authenticated]

      before_actions do
        only(:index, :authenticate) { @sign_in = Hello::Business::Authentication::SignIn.new }
      end

      # GET /hello/sign_in
      def index
        render_sign_in
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

      def render_sign_in
        render 'hello/authentication/sign_in'
      end
    end
  end
end
