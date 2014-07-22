require_dependency "hello/application_controller"

module Hello
module Classic
  class RegistrationController < ApplicationController

    before_actions do
      actions(:reset, :save) { fetch_registration_reset_ivar }
      actions(:reset_token)  { clear_hello_session }
    end


    # GET /hello/sign_up
    def sign_up
      @registration_sign_up = RegistrationSignUp.new
    end

        # POST /hello/sign_up
        def create
          @registration_sign_up = RegistrationSignUp.new(sign_up_params)
          @credential = @registration_sign_up.credential
          @password = sign_up_params[:password]

          if @registration_sign_up.save
            flash[:notice] = t("hello.messages.classic.registration.sign_up.notice")
            instance_eval(&sign_up_config.success)
          else
            instance_eval(&sign_up_config.error)
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
            flash[:notice] = t("hello.messages.classic.registration.sign_in.notice")
            instance_eval(&sign_in_config.success)
          else
            instance_eval(&sign_in_config.error)
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
          @registration_forgot = RegistrationForgot.new(forgot_login_param)
          @credential = @registration_forgot.credential

          if @registration_forgot.reset
            flash[:notice] = t("hello.messages.classic.registration.forgot_password.notice")
            instance_eval(&forgot_config.success)
          else
            instance_eval(&forgot_config.error)
          end
        end

            # GET /hello/after_forgot
            def after_forgot
            end





    # GET /hello/reset/token/:token
    def reset_token
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
        end

            # POST /hello/reset
            def save
              if @registration_reset.update_password(reset_password_param)
                @credential.invalidate_password_token
                flash[:notice] = t("hello.messages.classic.registration.reset_password.notice")
                instance_eval(&reset_config.success)
              else
                instance_eval(&reset_config.error)
              end
            end

                # GET /hello/after_reset
                def after_reset
                end





    private

        def fetch_registration_reset_ivar
          return redirect_to classic_forgot_path unless session[:hello_reset_token]
          @registration_reset = RegistrationReset.new(session[:hello_reset_token])
          @credential = @registration_reset.credential
        end

        def sign_up_params
          params.require(:registration_sign_up)
        end

        def forgot_login_param
          params.require(:registration_forgot)[:login]
        end

        def reset_password_param
          params.require(:registration_reset)[:password]
        end

        def sign_up_config
          Hello.config.sign_up
        end

        def sign_in_config
          Hello.config.sign_in
        end

        def forgot_config
          Hello.config.forgot
        end

        def reset_config
          Hello.config.reset
        end





  end

end
end
