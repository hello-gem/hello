class HelloGenerator < Rails::Generators::Base
  # source_root File.expand_path('../templates', __FILE__)
  source_root File.expand_path("../../../../../", __FILE__)

  def copy_the_configurators
    directory "app/lib/hello"
  end

  def append_to_the_routes
    route 'mount Hello::Engine => "/hello"'
  end

  def create_the_migrations
    rake "hello:install:migrations"
  end

  def tell_programmer_what_to_do_next
    the_root = File.expand_path("../../../../../", __FILE__)
    app_html_erb = File.join(the_root, "spec/dummy/app/views/layouts/application.html.erb")
    user_rb      = File.join(the_root, "app/models/user.rb")
    credential_rb  = File.join(the_root, "app/models/credential.rb")


    puts "-" * 100
    puts "Hello Developer,\nfor a better experience using this gem,\nplease modify the files below: ".red

    puts "-" * 100
    puts "\t\t\tapp/views/layouts/application.html.erb".green
      puts "-" * 100
      puts open(app_html_erb).read.green
      puts "\n" * 3
      puts "-" * 100
    puts "\t\t\t\t\tapp/models/user.rb".green
      puts "-" * 100
      puts open(user_rb).read.green
      puts "\n" * 3
      puts "-" * 100
    puts "\t\t\t\t\tapp/models/credential.rb".green
      puts "-" * 100
      puts open(credential_rb).read.green
      puts "\n" * 3
      puts "-" * 100
  end


  # hook_for :test_framework

  protected

end
