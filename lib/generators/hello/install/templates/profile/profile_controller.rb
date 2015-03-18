class ProfileController < ApplicationController

  before_action do
    @user = User.find_by_username(params[:username])
  end

  def profile
    respond_to do |format|
      format.html {  }
      format.json { render json: @user, status: :ok }
    end
  end

end
