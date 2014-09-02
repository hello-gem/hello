class ProfileController < ApplicationController

  before_action do
    @credential = Credential.find_by_username(params.require(:username))
    @user       = @credential.user
  end

  def profile
    respond_to do |format|
      format.html {  }
      format.json { render json: @user, status: :ok }
    end
  end

end
