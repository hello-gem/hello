require_dependency "hello/application_controller"

module Hello
  class SwitchUsersController < ApplicationController

    dont_kick_people

    before_actions do
      all { @accesses = current_accesses }
      only(:switch, :forget) { @access = current_accesses_find_by_id(params[:id]) }
    end

    # GET /hello/switch_users
    def index
    end

    # GET /hello/switch_users/1
    def switch
      self.session_token = @access.token
      redirect_to hello.switch_users_path, notice: "Switched Accounts Successfully!"
    end

    # DELETE /hello/switch_users/1
    def forget
      @access.destroy
      self.session_token = nil
      redirect_to hello.switch_users_path, notice: "Signed Out Successfully!"
    end

    private

    def current_accesses_find_by_id(string)
      current_accesses.select { |at| at.id.to_s == string }.first
    end

  end
end
