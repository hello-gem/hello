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
            instance_eval(&Hello.config.sign_up.success)
          else
            instance_eval(&Hello.config.sign_up.error)
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
            instance_eval(&Hello.config.sign_in.success)
          else
            instance_eval(&Hello.config.sign_in.error)
          end
        end

            # GET /hello/sign_in/welcome
            def sign_in_welcome
            end






    # GET /hello/forgot
    def forgot
      @password_forgot = PasswordForgot.new
    end

        # POST /hello/forgot
        def ask
          @password_forgot = PasswordForgot.new(params[:login])
          @identity = @password_forgot.identity

          if @password_forgot.reset
            instance_eval(&Hello.config.forgot.success)
          else
            instance_eval(&Hello.config.forgot.error)
          end
        end

            # GET /hello/forgot/welcome
            def forgot_welcome
            end





    # GET /hello/reset/token/:token
    def reset_token
      clear_hello_session

      @password_reset = PasswordReset.new(params[:token])
      if @password_reset.identity
        session[:hello_reset_token] = params[:token]
        redirect_to password_reset_path
      else
        redirect_to password_forgot_path, alert: "This link has expired, please ask for a new link"
      end
    end

        # GET /hello/reset
        def reset
          # authorization
          redirect_to password_forgot_path unless session[:hello_reset_token]

          @password_reset = PasswordReset.new(session[:hello_reset_token])
        end

            # POST /hello/reset
            def save
              # authorization
              redirect_to password_forgot_path unless session[:hello_reset_token]

              @password_reset = PasswordReset.new(session[:hello_reset_token])
              @identity = @password_reset.identity

              if @password_reset.update_password(params[:password])
                @identity.invalidate_token
                instance_eval(&Hello.config.reset.success)
              else
                instance_eval(&Hello.config.reset.error)
              end
            end

  end
end
