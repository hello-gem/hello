class NoviceController < Hello::ApplicationController

  restrict_unless_role_is :novice
  
  def index
  end
  
  def continue
    current_user.update! role: User.user
    redirect_to '/'
  end

end
