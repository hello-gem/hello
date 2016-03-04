class Hello::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_the_initializer
    copy_file 'initializer.rb', 'config/initializers/hello.rb'
  end

  def locale_fix
    gsub_file 'config/locales/en.yml', 'hello: "Hello world"', 'hello_world: "Hello world"'
  rescue Errno::ENOENT
  end

  # a root route is needed
  # we were previously redirecting to /hello which caused a redirection loop bug
  def generate_root
    my_route "root to: 'root#index'"
    copy_file 'root/root_controller.rb', 'app/controllers/root_controller.rb'
    copy_file 'root/index.html.erb',     'app/views/root/index.html.erb'
  end

  def append_to_the_routes
    my_route 'mount Hello::Engine => "/hello"'
    my_route "get '/hello/sign_out' => 'sessions#sign_out'"
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
    copy_file 'models/user.rb', 'app/models/user.rb'
  end

  def generate_profile
    my_route %(
  resources :users, only: [:index, :show] do
    collection do
      get 'list'
    end
    member do
      post 'impersonate'
    end
  end
)
    directory 'users/controllers', 'app/controllers'
    directory 'users/views', 'app/views'
  end

  def generate_onboarding
    my_route %(
  get  'onboarding' => 'onboarding#index'
  post 'onboarding' => 'onboarding#continue'
    )
    copy_file 'onboarding/onboarding_controller.rb', 'app/controllers/onboarding_controller.rb'
    copy_file 'onboarding/index.html.erb',           'app/views/onboarding/index.html.erb'
  end

  # hook_for :test_framework

  protected

  def my_route(routing_code)
    log :route, routing_code
    sentinel = /\.routes\.draw do\s*$/

    in_root do
      inject_into_file 'config/routes.rb', "\n  #{routing_code}", after: sentinel, verbose: false, force: false
    end
  end
end
