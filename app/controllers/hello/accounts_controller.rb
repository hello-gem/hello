require_dependency "hello/application_controller"

module Hello
  class AccountsController < ApplicationController

    dont_kick_people

    before_actions do
      all { @access_tokens = current_access_tokens }
      only(:show, :destroy) { @access_token = current_access_tokens_find_by_id(params[:id]) }
    end

    # GET /hello/accounts
    def index
    end

    # GET /hello/accounts/1
    def show
      self.session_access_token = @access_token.access_token
      redirect_to hello.accounts_path, notice: "Switched Accounts Successfully!"
    end

    # DELETE /hello/accounts/1
    def destroy
      @access_token.destroy
      self.session_access_token = nil
      redirect_to hello.accounts_path, notice: "Signed Out Successfully!"
    end

    private

    def current_access_tokens_find_by_id(string)
      current_access_tokens.select { |at| at.id.to_s == string }.first
    end

  end
end
