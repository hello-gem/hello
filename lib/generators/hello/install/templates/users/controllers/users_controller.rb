class UsersController < ApplicationController

  dont_kick_people

  # GET /users
  def index
    @users = User.order(:id)
  end

  # GET /users/username
  # GET /users/id -> redirects to /users/username
  def show
    @user = User.find_by_username!(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to User.find_by_id!(params[:id]) # forces redirect to path with username if used id on URL
  end

end
