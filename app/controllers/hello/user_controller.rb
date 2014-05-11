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
      config = Hello.config.user
      if @user.update(user_params)
        instance_eval(&config.success)
      else
        instance_eval(&config.error)
      end
    end

    private

        def user_params
          column_names = User.hello_profile_column_names
          params.require(:user).permit(*column_names)
        end

  end
end
