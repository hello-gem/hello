class Hello::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_the_initializer
    copy_file "initializer.rb", "config/initializers/hello.rb"
  end

  def locale_fix
    gsub_file 'config/locales/en.yml', 'hello: "Hello world"', 'hello_world: "Hello world"'
  rescue Errno::ENOENT
  end

  # a root route is needed
  # we were previously redirecting to /hello which caused a redirection loop bug
  def generate_root
    route "root to: 'root#index'"
    copy_file "root/root_controller.rb", "app/controllers/root_controller.rb"
    copy_file "root/index.html.erb",     "app/views/root/index.html.erb"
  end

  def append_to_the_routes
    route 'mount Hello::Engine => "/hello"'
  end

  def create_the_migrations
    rake "hello:install:migrations"
  end

  def create_layout_file
    destination = "app/views/layouts/application.html.erb"
    if yes?("Replace application.html.erb automatically?")
      copy_file "application.html.erb", "app/views/layouts/application.html.erb"
    else
      the_template_path = File.expand_path('../templates', __FILE__)
      app_erb_path = File.join(the_template_path, "application.html.erb")
      content = open(app_erb_path).read
      puts ("-" * 100).light_yellow
      puts "  We recommend you add these elements to your application.html.erb file".light_yellow
      puts ("-" * 100).light_yellow
      puts content.light_green.on_black.bold
      puts ("-" * 100).light_yellow
    end
  end

  def create_models
    copy_file "credential.rb",     "app/models/credential.rb"
    copy_file "access_token.rb", "app/models/access_token.rb"
    copy_file "user.rb",           "app/models/user.rb"
  end

  def generate_profile
    route "resources :users, only: [:index, :show]"
    directory "users/controllers", "app/controllers"
    directory "users/views", "app/views"
  end

  def generate_novice
    route %{
  get  'novice' => 'novice#index'
  post 'novice' => 'novice#continue'
    }
    copy_file "novice/novice_controller.rb", "app/controllers/novice_controller.rb"
    copy_file "novice/index.html.erb",       "app/views/novice/index.html.erb"
  end


  # hook_for :test_framework

  protected

end
