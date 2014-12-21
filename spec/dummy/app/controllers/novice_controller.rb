class NoviceController < Hello::ApplicationController

  restrict_unless_role_is :novice

  def index
  end
  
  def continue
    if params[:agree]
      current_user.update! role: User.user
      redirect_to hello.user_path
    else
      @show_agree_error = true
      render action: 'index'
    end
  end

end
