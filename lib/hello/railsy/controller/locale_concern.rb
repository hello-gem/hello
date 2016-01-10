module Hello
  module Railsy
    module Controller
      module LocaleConcern
        extend ActiveSupport::Concern

        module ClassMethods
        end

        def available_locales
          Hello.available_locales
        end

        def available_locales_with_names
          Hello.all_locale_names.select { |k, _v| available_locales.include? k }
        end

        def hello_locale_select_options
          # [['English', 'en']]
          available_locales_with_names.map { |k, v| [v, k] }
        end

        def set_locale(locale)
          current_user && current_user.update!(locale: locale)
          use_locale(locale)
        end

        def recommended_locale
          x = http_accept_language.compatible_language_from(Hello.available_locales)
          x || Hello.default_locale
        end

        included do
          before_action :use_locale
          helper_method :available_locales, :available_locales_with_names, :hello_locale_select_options
        end

        private

        def use_locale(locale = nil)
          locale ||= current_user && current_user.locale
          locale ||= session['locale']
          locale ||= recommended_locale.to_s

          I18n.locale = session['locale'] = locale
        end
      end
    end
  end
end
