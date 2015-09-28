class UsersController < ApplicationController

  dont_kick_people

  # GET /users
  def index
    @users = User.order(:id)
  end

  # GET /users/username
  def show
    @user = User.find_by_username!(params[:id]) rescue User.find(params[:id])
  end
end
