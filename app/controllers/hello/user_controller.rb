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
        instance_eval(&Hello.config.user.success)
      else
        instance_eval(&Hello.config.user.error)
      end
    end

    private

        def user_params
          column_names = User.hello_profile_column_names
          params.require(:user).permit(*column_names)
        end

  end
end
