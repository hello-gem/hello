 require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class SignOutController < ApplicationController

    # GET /hello/sign_out
    def sign_out
      destroy_and_clear_hello_active_session
      flash.now[:notice] = t("hello.messages.common.sign_out.sign_out.notice")
      control = SignOutControl.new(self, nil)
      control.success
    end
    
  end
end
