class UsersController < ApplicationController

  before_actions do
    actions(:index) { @users = User.all }
    actions(:show)  { @user = User.find(params.require(:id)) }
  end

  # GET /users
  def index
  end

  # GET /users/1
  def show
  end

end
