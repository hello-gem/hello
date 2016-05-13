require 'hello'

class Hello::ViewsGenerator < Rails::Generators::Base
  source_root Hello.root

  def copy_the_views
    directory 'app/views/hello'
  end
end
