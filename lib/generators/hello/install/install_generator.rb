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

  def inject_suggested_header
    puts "\t\t\tapp/views/layouts/application.html.erb".green

    the_template_path = File.expand_path('../templates', __FILE__)
    suggested_header_erb = File.join(the_template_path, "suggested_header.html.erb")
    after_regex = /<body(.*)>/i
    destination = 'app/views/layouts/application.html.erb'
    content = open(suggested_header_erb).read

    inject_into_file destination, content, after: after_regex

  rescue Errno::ENOENT
    copy_file "suggested_application.html.erb", destination
  end

  def create_models
    copy_file "credential.rb",     "app/models/credential.rb"
    copy_file "access_token.rb", "app/models/access_token.rb"
    copy_file "user.rb",           "app/models/user.rb"
  end

  def tell_programmer_what_to_do_next
    the_root = File.expand_path("../../../../../", __FILE__)
    user_rb  = File.join(the_root, "app/models/user.rb")

    puts "-" * 100
    puts "Hello Developer,\nplease keep the user model in mind: ".red

    puts "\t\t\t\t\tapp/models/user.rb".green
      puts "-" * 100
      puts open(user_rb).read.green
      puts "\n" * 3
      puts "-" * 100
  end

  def generate_profile
    route "get 'profile/:username' => 'profile#profile', as: 'profile'"
    copy_file "profile/profile_controller.rb", "app/controllers/profile_controller.rb"
    copy_file "profile/profile.html.erb",      "app/views/profile/profile.html.erb"
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
