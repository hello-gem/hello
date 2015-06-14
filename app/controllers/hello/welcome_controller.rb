require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class WelcomeController < ApplicationController

    restrict_if_authenticated only: [:index]

    # GET /hello
    def index
      @sign_up = SignUpEntity.new(self)
      @sign_in = SignInEntity.new
    end

    # GET /hello/homepage
    def homepage
      homepages = {
        guest:  hello.sign_in_path,
        novice: '/novice',
        admin:  hello.admin_path,
      }

      role = (current_user && current_user.role || 'guest').to_sym
      redirect_to homepages[role] || hello.current_user_path
    end

  end
end
