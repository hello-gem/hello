class Hello::ControllersGenerator < Rails::Generators::Base
  # source_root File.expand_path('../templates', __FILE__)
  source_root File.expand_path("../../../../../", __FILE__)

  def copy_the_controllers
    files = %w(current_user sign_out email_sign_up email_sign_in email_forgot_password reset_password deactivation)
    files.each do |f|
      s = "app/controllers/hello/#{f}_controller.rb"
      copy_file s, s  
    end
  end



  protected

end
