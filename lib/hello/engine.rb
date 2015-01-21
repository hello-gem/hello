module Hello
  class Engine < ::Rails::Engine
    isolate_namespace Hello

    config.generators do |g|
      g.test_framework :rspec, view_specs: false,
                               controller_specs: false
      # g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

  end
end
