require_dependency "hello/application_controller"

module Hello
  class WelcomeController < ApplicationController

    # GET /hello
    def index
      @password_sign_up = PasswordSignUp.new
    end

    # GET /hello/sign_out
    def sign_out
      clear_hello_session
      instance_eval(&Hello.sign_out.success)
    end


  end
end
