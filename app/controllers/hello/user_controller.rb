require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class UserController < ApplicationController

    before_actions do
      actions { @user = hello_user }
    end

    # GET /hello/user
    def edit
      respond_to do |format|
        format.html {  }
        format.json { render json: @user.to_hash_profile, status: :ok }
      end
    end

    # PATCH /hello/user
    def update
      c = Hello.config(:user)
      
      if @user.update(user_params)
        flash[:notice] = I18n.t("hello.messages.common.user.edit.notice")
        instance_eval(&c.success_block)
      else
        instance_eval(&c.failure_block)
      end
    end

    private

        def user_params
          column_names = User.hello_profile_column_names
          params.require(:user).permit(*column_names)
        end

  end
end
