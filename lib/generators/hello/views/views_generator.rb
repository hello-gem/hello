class Hello::ViewsGenerator < Rails::Generators::Base
  # source_root File.expand_path('../templates', __FILE__)
  source_root File.expand_path("../../../../../", __FILE__)

  def copy_the_views
    directory "app/views/hello"
  end

  def copy_the_locales
    copy_file "config/locales/hello.en.yml", "config/locales/hello.en.yml"
  end


  protected

end
