module Hello
  module Rails
    module Controller
      module LocaleConcern
        
        extend ActiveSupport::Concern

        module ClassMethods
        end

        def hello_recommended_locale
          # http_accept_language.compatible_language_from(I18n.available_locales)
          http_accept_language.compatible_language_from(Hello.available_locales) || 'en'
        end

        def available_locales
          Hello.available_locales
        end

        def available_locales_with_names
          Hello.all_locale_names.select { |k,v| available_locales.include? k }
        end

        included do
          before_action :set_locale
          helper_method :available_locales, :available_locales_with_names
        end

        private

            # locale

            def set_locale
              I18n.locale = session['locale'] ||= hello_recommended_locale.to_s
            end

      end
    end
  end
end
