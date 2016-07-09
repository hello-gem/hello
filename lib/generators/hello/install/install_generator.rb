class Hello::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_the_initializer
    copy_file 'initializer.rb', 'config/initializers/hello.rb'
  end

  def locale_fix
    gsub_file 'config/locales/en.yml', 'hello: "Hello world"', 'hello_world: "Hello world"'
  rescue Errno::ENOENT
  end

  def generate_helper
    copy_file 'hello_helper.rb', 'app/helpers/hello_helper.rb'
  end

  # a root route is needed
  # we were previously redirecting to /hello which caused a redirection loop bug
  def generate_root
    route "root to: 'root#index'"
    copy_file 'root/root_controller.rb', 'app/controllers/root_controller.rb'
    copy_file 'root/index.html.erb',     'app/views/root/index.html.erb'
  end

  def append_to_the_routes
    route 'mount Hello::Engine => "/hello"'
    route "get '/hello/sign_out' => 'hello/authentication/sessions#sign_out'"
  end

  def create_the_migrations
    rake 'hello:install:migrations'
  end

  def create_layout_file
    destination = 'app/views/layouts/application.html.erb'

    answer = ask('Replace application.html.erb automatically? [Yn]')
    answer_yes = answer.blank? || answer.downcase.starts_with?('y')

    if answer_yes
      copy_file 'application.html.erb', 'app/views/layouts/application.html.erb'
    else
      the_template_path = File.expand_path('../templates', __FILE__)
      app_erb_path = File.join(the_template_path, 'application.html.erb')
      content = open(app_erb_path).read
      puts ('-' * 100).light_yellow
      puts '  We recommend you add these elements to your application.html.erb file'.light_yellow
      puts ('-' * 100).light_yellow
      puts content.light_green.on_black.bold
      puts ('-' * 100).light_yellow
    end
  end

  def create_models
    directory 'models', 'app/models'
  end

  def generate_onboarding
    route %(
  get  'onboarding' => 'onboarding#index'
  post 'onboarding' => 'onboarding#continue'
    )
    copy_file 'onboarding/onboarding_controller.rb', 'app/controllers/onboarding_controller.rb'
    copy_file 'onboarding/index.html.erb',           'app/views/onboarding/index.html.erb'
  end

  # hook_for :test_framework

end
