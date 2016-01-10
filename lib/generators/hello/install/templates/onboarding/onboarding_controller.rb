class OnboardingController < ApplicationController
  dont_kick :onboarding

  def index
  end

  def continue
    respond_to do |format|
      if update(params[:role])
        format.html { redirect_to root_path, notice: 'Welcome!' }
        format.json { render json: { user: current_user.as_json_web_api }, status: :ok }
      else
        format.html { render action: 'index' }
        format.json { render json: { errors: 'invalid role supplied' }, status: :unprocessable_entity }
      end
    end
  end

  private

  def update(role)
    case role
    when 'user'
      current_user.update! role: 'user'
      return true
    when 'webmaster'
      current_user.update! role: 'webmaster'
      return true
    else
      return false
    end
  end
end
