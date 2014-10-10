class NoviceController < ApplicationController

  def index
  end
  
  def continue
    current_user.update! role: User.user
    redirect_to root_path
  end

end
