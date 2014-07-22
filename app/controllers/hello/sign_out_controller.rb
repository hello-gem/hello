 require_dependency "hello/application_controller"

module Hello
  class SignOutController < ApplicationController

    # GET /hello/sign_out
    def sign_out
      clear_hello_session
      flash.now[:notice] = t("hello.messages.common.sign_out.sign_out.notice")
      instance_eval(&Hello.config.sign_out.success)
    end


  end
end
