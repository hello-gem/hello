require_dependency 'hello/application_controller'

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class RootController < ApplicationController
    dont_kick :guest

    # GET /hello
    def index
      @sign_up = Business::Registration::SignUp.new
      @sign_in = Business::Authentication::SignIn.new
    end
  end
end
