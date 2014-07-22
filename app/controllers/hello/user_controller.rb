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
        flash[:notice] = I18n.t("hello.messages.common.user.edit.notice")
        instance_eval(&user_config.success)
      else
        instance_eval(&user_config.error)
      end
    end

    private

        def user_params
          column_names = User.hello_profile_column_names
          params.require(:user).permit(*column_names)
        end

        def user_config
          Hello.config.user
        end

  end
end
