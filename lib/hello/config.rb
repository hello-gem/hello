require "hello/config/base"
require "hello/config/password/sign_up"
require "hello/config/password/sign_in"
require "hello/config/password/sign_out"
require "hello/config/password/forgot"
require "hello/config/password/reset"
require "hello/config/user"

# require "hello/config/oauth2/twitter"

module Hello
  class Config
    include Singleton

    def sign_up
      @sign_up ||= SignUp.new
    end

    def sign_in
      @sign_in ||= SignIn.new
    end

    def sign_out
      @sign_out ||= SignOut.new
    end

    def forgot
      @forgot ||= Forgot.new
    end

    def reset
      @reset ||= Reset.new
    end

    def user
      @user ||= User.new
    end

    # def twitter
    #   @twitter ||= Twitter.new
    # end

  end
end
