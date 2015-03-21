class DeactivationControl < Hello::AbstractControl
  
  alias :deactivation :entity

  def deactivate
    # c.hello_user.update! deactivated_at: Time.now
    # c.hello_user.update! deactivated: true
    c.hello_user.destroy!
  rescue ActiveRecord::RecordNotDestroyed => invalid
    raise ActiveRecord::Rollback
  end

  def success
    c.respond_to do |format|
      format.html { c.redirect_to c.hello.deactivation_done_path }
      format.json { c.render json: {deactivated: true}, status: :ok }
    end
  end

end
