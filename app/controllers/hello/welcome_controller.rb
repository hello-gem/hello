 require_dependency "hello/application_controller"

module Hello
  class WelcomeController < ApplicationController

    # GET /hello
    def index
      @registration_sign_up = RegistrationSignUp.new
      @registration_sign_in = RegistrationSignIn.new
    end

  end
end
