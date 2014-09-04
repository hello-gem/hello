class SignOutControl < Hello::AbstractControl
  
  def success


    c.respond_to do |format|
      # format.html { c.redirect_to c.hello.root_path }
      # format.html { c.redirect_to c.root_path }
      format.html { c.render :sign_out }
      format.json { c.head :reset_content }
    end
  end

end
