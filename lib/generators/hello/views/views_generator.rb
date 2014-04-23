class Hello::ViewsGenerator < Rails::Generators::Base
  # source_root File.expand_path('../templates', __FILE__)
  source_root File.expand_path("../../../../../", __FILE__)

  def copy_initializer_file
    directory "app/views/hello"
  end


  protected

end
