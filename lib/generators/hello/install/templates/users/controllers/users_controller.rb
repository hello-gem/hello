class UsersController < ApplicationController

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/username
  def show
    # @user = User.find(params[:id])
    @user = User.find_by_username(params[:id]) || raise(ActiveRecord::RecordNotFound)
  end
end
