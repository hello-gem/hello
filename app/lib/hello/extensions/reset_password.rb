# Generated with gem 'hello', '<%= Hello::VERSION %>'
# Learn more at config/initializers/hello.rb
#
module Hello
  module Extensions
    module ResetPassword

      def success
        # comment the line below in order to force the user to sign in manually
        access_token = sign_in!(@reset_password.user, expires_at)

        redirect_to hello.password_reset_done_path
      end

      def failure
        render action: 'index'
      end



      def expires_at
        30.days.from_now
      end

    end
  end
end
