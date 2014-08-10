require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class WelcomeController < ApplicationController

    # GET /hello
    def index
      @registration_sign_up = RegistrationSignUp.new
      @registration_sign_in = RegistrationSignIn.new
    end

  end
end
