require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class WelcomeController < ApplicationController

    # GET /hello
    def index
      @sign_up = SignUpEntity.new(self)
      @sign_in = SignInEntity.new
    end

  end
end
