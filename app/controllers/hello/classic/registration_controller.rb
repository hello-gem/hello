require_dependency "hello/application_controller"

module Hello
module Classic
  class RegistrationController < ApplicationController




    # GET /hello/sign_up
    def sign_up
      @registration_sign_up = RegistrationSignUp.new
    end

        # POST /hello/sign_up
        def create
          sign_up_params = params.require(:registration_sign_up)
          @registration_sign_up = RegistrationSignUp.new(sign_up_params)
          @credential = @registration_sign_up.credential

          if @registration_sign_up.save
            instance_eval(&Hello.config.sign_up.success)
          else
            instance_eval(&Hello.config.sign_up.error)
          end
        end

            # GET /hello/after_sign_up
            def after_sign_up
            end







    # GET /hello/sign_in
    def sign_in
      @registration_sign_in = RegistrationSignIn.new
    end

        # POST /hello/sign_in
        def authenticate
          @registration_sign_in = RegistrationSignIn.new(self)
          @credential = @registration_sign_in.credential

          if @registration_sign_in.authenticate
            instance_eval(&Hello.config.sign_in.success)
          else
            instance_eval(&Hello.config.sign_in.error)
          end
        end

            # GET /hello/after_sign_in
            def after_sign_in
            end






    # GET /hello/forgot
    def forgot
      @registration_forgot = RegistrationForgot.new
    end

        # POST /hello/forgot
        def ask
          login = params.require(:registration_forgot)[:login]
          @registration_forgot = RegistrationForgot.new(login)
          @credential = @registration_forgot.credential

          if @registration_forgot.reset
            instance_eval(&Hello.config.forgot.success)
          else
            instance_eval(&Hello.config.forgot.error)
          end
        end

            # GET /hello/after_forgot
            def after_forgot
            end





    # GET /hello/reset/token/:token
    def reset_token
      clear_hello_session

      @registration_reset = RegistrationReset.new(params[:token])
      if @registration_reset.credential
        session[:hello_reset_token] = params[:token]
        redirect_to classic_reset_path
      else
        redirect_to classic_forgot_path, alert: "This link has expired, please ask for a new link"
      end
    end

        # GET /hello/reset
        def reset
          # authorization
          redirect_to classic_forgot_path unless session[:hello_reset_token]

          @registration_reset = RegistrationReset.new(session[:hello_reset_token])
        end

            # POST /hello/reset
            def save
              # authorization
              redirect_to classic_forgot_path unless session[:hello_reset_token]

              @registration_reset = RegistrationReset.new(session[:hello_reset_token])
              @credential = @registration_reset.credential


              new_password = params.require(:registration_reset)[:password]
              if @registration_reset.update_password(new_password)
                @credential.invalidate_password_token
                instance_eval(&Hello.config.reset.success)
              else
                instance_eval(&Hello.config.reset.error)
              end
            end

                # GET /hello/after_reset
                def after_reset
                end

  end

end
end
