module Hello
  module RailsHelper
    def method_missing(method, *args, &block)
      # # http://candland.net/2012/04/17/rails-routes-used-in-an-isolated-engine/
      # puts "LOOKING FOR ROUTES #{method}"
      return super unless method.to_s.end_with?('_path', '_url')
      return super unless main_app.respond_to?(method)
      main_app.send(method, *args)
    end

    def respond_to?(method)
      return super unless method.to_s.end_with?('_path', '_url')
      return super unless main_app.respond_to?(method)
      true
    end

    # [['English', 'en']]
    def hello_locale_select_options
      available_locales_with_names.map { |k, v| [v, k] }
    end

    def human_current_locale
      t('hello.locale_name')
    end

    def current_locale
      session['locale']
    end

    def available_locales_with_names
      Hello::Locales.all.select { |k, _v| Hello.configuration.locales.include? k }
    end

  end
end
