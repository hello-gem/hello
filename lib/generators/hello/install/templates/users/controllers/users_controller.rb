class UsersController < ApplicationController
  sudo_mode only: [:list, :impersonate]
  dont_kick :webmaster, only: [:list, :impersonate]
  before_action :find_user, only: [:show, :impersonate]

  # GET /users
  def index
    @users = User.order(:id)
  end

  # GET /users/list
  def list
    @users = User.order(:id)
    @count = User.count
  end

  # GET /users/username
  # GET /users/id -> redirects to /users/username
  def show
  end

  # POST /users/1/impersonate
  def impersonate
    sign_in!(@user, 60.minutes.from_now, 60.minutes.from_now)

    redirect_to root_path, notice: t('hello.entities.sign_in.success')
  end

  private

  def find_user
    @user = User.find_by_username!(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to User.find_by_id!(params[:id]) # forces redirect to path with username if used id on URL
  end
end
