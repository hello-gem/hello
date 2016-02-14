require_dependency 'hello/application_controller'

module Hello
  class SwitchUsersController < ApplicationController
    dont_kick_people

    before_actions do
      only(:index) { @accesses = current_accesses }
      only(:show, :destroy) { @access = current_accesses.find { |at| at.id.to_s == params[:id] } }
    end

    # GET /hello/switch_users
    def index
    end

    # GET /hello/switch_users/new
    def new
    end

    # GET /hello/switch_users/1
    def show
      entity = SwitchUserEntity.new
      self.session_token = @access.token
      redirect_to hello.switch_users_path, notice: entity.success_message
    end

    # DELETE /hello/switch_users/1
    def destroy
      @access && @access.destroy!
      self.session_token = nil
      redirect_to hello.switch_users_path, notice: 'Signed Out Successfully!'
    end
  end
end
