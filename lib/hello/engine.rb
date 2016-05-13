module Hello
  class Engine < Rails::Engine
    isolate_namespace Hello

    config.hello = nil

    initializer 'hello.filter' do |app|
      app.config.filter_parameters += [:password, :token]
    end

    initializer 'hello.add_middleware' do |app|
      app.config.app_middleware.use Hello::Middleware
    end

    config.generators do |g|
      g.test_framework :rspec, view_specs: false,
                               controller_specs: false
      # g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
