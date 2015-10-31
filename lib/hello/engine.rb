require_relative "manager"

module Hello
  class Engine < Rails::Engine
    isolate_namespace Hello

    initializer "hello.filter" do |app|
      app.config.filter_parameters += [:password, :token]
    end

    initializer "hello.add_middleware" do |app|
      app.config.app_middleware.use Hello::Manager::Middleware
    end

    initializer "hello.load_config" do |app|
      app.config.autoload_paths += %W(#{Engine.root}/lib)
      app.config.watchable_dirs["#{Engine.root}/lib"] = [:rb]
    end

    config.hello            = ActiveSupport::OrderedOptions.new
    config.hello.extensions = ActiveSupport::OrderedOptions.new

    config.generators do |g|
      g.test_framework :rspec, view_specs: false,
                               controller_specs: false
      # g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

  end
end
