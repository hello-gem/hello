require_dependency "hello/application_controller"

module Hello
  class WelcomeController < ApplicationController

    # GET /hello
    def index
      @registration_sign_up = RegistrationSignUp.new
      @registration_sign_in = RegistrationSignIn.new
    end

    # GET /hello/sign_out
    def sign_out
      clear_hello_session
      instance_eval(&Hello.config.sign_out.success)
    end


  end
end
