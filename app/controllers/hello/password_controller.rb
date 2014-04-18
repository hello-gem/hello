require_dependency "hello/application_controller"

module Hello
  class PasswordController < ApplicationController




    # GET /hello/sign_up
    def sign_up
      @password_sign_up = PasswordSignUp.new
    end

        # POST /hello/sign_up
        def create
          @password_sign_up = PasswordSignUp.new(params)
          @identity = @password_sign_up.identity

          if @password_sign_up.save
            instance_eval(&Hello.sign_up.success)
          else
            instance_eval(&Hello.sign_up.error)
          end
        end

            # GET /hello/sign_up/welcome
            def sign_up_welcome
            end




    # GET /hello/sign_in
    def sign_in
      @password_sign_in = PasswordSignIn.new
    end

        # POST /hello/sign_in
        def authenticate
          @password_sign_in = PasswordSignIn.new(self)
          @identity = @password_sign_in.identity

          if @password_sign_in.authenticate
            instance_eval(&Hello.sign_in.success)
          else
            instance_eval(&Hello.sign_in.error)
          end
        end

            # GET /hello/sign_in/welcome
            def sign_in_welcome
            end

  end
end
