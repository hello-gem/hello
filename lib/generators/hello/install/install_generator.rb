class Hello::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_the_configurators
    the_root = File.expand_path("../../../../../", __FILE__)
    directory "#{the_root}/app/lib/hello", "app/lib/hello"
  end

  def locale_fix
    gsub_file 'config/locales/en.yml', 'hello: "Hello world"', 'hello_world: "Hello world"'
  end

  def append_to_the_routes
    route "root to: redirect('/hello') # TODO: add a custom root route :)"
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
    copy_file "active_session.rb", "app/models/active_session.rb"
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


  # hook_for :test_framework

  protected

end
