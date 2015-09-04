class Hello::ModulesGenerator < Rails::Generators::Base
  # source_root File.expand_path('../templates', __FILE__)
  source_root File.expand_path("../../../../../", __FILE__)

  def copy_them
    directory "app/lib"
  end

end
