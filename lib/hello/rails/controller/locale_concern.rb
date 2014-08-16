module Hello
  module Rails
    module Controller
      module LocaleConcern
        
        extend ActiveSupport::Concern

        module ClassMethods
        end

        def hello_recommended_locale
          default_locale = ::Rails.application.config.i18n.default_locale || 'en'
          # http_accept_language.compatible_language_from(I18n.available_locales)
          http_accept_language.compatible_language_from(Hello.available_locales) || default_locale
        end

        def available_locales
          Hello.available_locales
        end

        def available_locales_with_names
          Hello.all_locale_names.select { |k,v| available_locales.include? k }
        end

        def hello_locale_select_options
          # [['English', 'en']]
          available_locales_with_names.map { |k,v| [v, k] }
        end


        included do
          before_action :set_locale
          helper_method :available_locales, :available_locales_with_names, :hello_locale_select_options
        end

        private

            # locale

            def set_locale
              v = if hello_user
                    hello_user.locale
                  else
                    hello_recommended_locale.to_s
                  end
              I18n.locale = session['locale'] ||= v
            end


      end
    end
  end
end
