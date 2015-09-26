require_dependency "hello/application_controller"

module Hello
  class SwitchUsersController < ApplicationController

    dont_kick_people

    before_actions do
      all { @access_tokens = current_access_tokens }
      only(:switch, :forget) { @access_token = current_access_tokens_find_by_id(params[:id]) }
    end

    # GET /hello/switch_users
    def index
    end

    # GET /hello/switch_users/1
    def switch
      self.session_access_token = @access_token.access_token
      redirect_to hello.switch_users_path, notice: "Switched Accounts Successfully!"
    end

    # DELETE /hello/switch_users/1
    def forget
      @access_token.destroy
      self.session_access_token = nil
      redirect_to hello.switch_users_path, notice: "Signed Out Successfully!"
    end

    private

    def current_access_tokens_find_by_id(string)
      current_access_tokens.select { |at| at.id.to_s == string }.first
    end

  end
end
