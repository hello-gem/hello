require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class Webmaster::RootController < ApplicationController

    dont_kick :webmaster

    # GET /hello/webmaster
    def index
      render text: "access granted :)", layout: 'application'
    end

  end
end
