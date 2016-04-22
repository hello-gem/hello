module Hello
  module Railsy
    module Controller
      module LocaleConcern
        extend ActiveSupport::Concern

        module ClassMethods
        end

        def available_locales
          Hello.configuration.locales
        end

        def available_locales_with_names
          Hello.all_locale_names.select { |k, _v| available_locales.include? k }
        end

        # [['English', 'en']]
        def hello_locale_select_options
          available_locales_with_names.map { |k, v| [v, k] }
        end

        def set_locale(locale)
          current_user && current_user.update!(locale: locale)
          use_locale(locale)
        end

        def recommended_locale
          x = http_accept_language.compatible_language_from(available_locales)
          x || I18n.default_locale
        end

        def human_current_locale
          t('hello.locale_name')
        end

        def current_locale
          session['locale']
        end

        included do
          before_action :use_locale
          helper_method :available_locales, :available_locales_with_names, :hello_locale_select_options, :human_current_locale, :current_locale
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
