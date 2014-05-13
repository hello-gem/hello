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
    
    def sign_in(&block)
      v = @sign_in ||= SignIn.new
      block_given? ? v.config(&block) : v
    end

    def sign_up(&block)
      v = @sign_up ||= SignUp.new
      block_given? ? v.config(&block) : v
    end

    def sign_out(&block)
      v = @sign_out ||= SignOut.new
      block_given? ? v.config(&block) : v
    end

    def forgot(&block)
      v = @forgot ||= Forgot.new
      block_given? ? v.config(&block) : v
    end

    def reset(&block)
      v = @reset ||= Reset.new
      block_given? ? v.config(&block) : v
    end

    def user(&block)
      v = @user ||= User.new
      block_given? ? v.config(&block) : v
    end

    # def twitter
    #   @twitter ||= Twitter.new
    # end

  end
end
