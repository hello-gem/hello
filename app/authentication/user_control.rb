class UserControl < Hello::AbstractControl
  
  alias :user :entity

  def success
    c.respond_to do |format|
      format.html { c.redirect_to c.hello.user_path }
      format.json { c.render json: user.to_hash_profile, status: :ok }
    end
  end

  def failure
    c.respond_to do |format|
      format.html { c.render :edit }
      format.json { c.render json: user.errors, status: :unprocessable_entity }
    end
  end

end
