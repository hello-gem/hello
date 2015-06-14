require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class Master::RootController < ApplicationController

    restrict_unless_role_is :master

    # GET /hello/master
    def index
      render text: "access granted :)", layout: 'application'
    end

  end
end
