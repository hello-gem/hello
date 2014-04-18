require_dependency "hello/application_controller"

module Hello
  class UserController < ApplicationController

    before_actions do
      actions { @user = hello_user }
    end

    # GET /hello/user
    def edit
    end

    # PATCH /hello/user
    def update
      if @user.update(user_params)
        redirect_to hello.user_path, notice: 'Your profile was successfully updated.'
      else
        render action: 'edit'
      end
    end


    private

        def user_params
          puts "user_params should be configurable"
          params.require(:user).permit(:name)
        end

  end
end
