class Hello::ExtensionsGenerator < Rails::Generators::Base
  # source_root File.expand_path('../templates', __FILE__)
  MY_SOURCE_ROOT = File.expand_path("../../../../../", __FILE__)
  source_root MY_SOURCE_ROOT

  def copy_the_extensions
    available_files.each do |filename|
      template filename
    end
  end

  protected

  def available_files
    a = Dir[File.join(MY_SOURCE_ROOT, "app/lib/hello/extensions/*.rb")]
    a.map { |s| s.gsub("#{MY_SOURCE_ROOT}/", "") }
  end
  
end
