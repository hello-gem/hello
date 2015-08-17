module Hello
  module Rails
    module Controller
      module LocaleConcern
        
        extend ActiveSupport::Concern

        module ClassMethods
        end

        def hello_recommended_locale
          default_locale = I18n.default_locale || 'en'
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

        def set_session_locale(v)
          session['locale'] = v
          hello_ensure_thread_locale
        end


        included do
          before_action :hello_ensure_thread_locale
          helper_method :available_locales, :available_locales_with_names, :hello_locale_select_options
        end

        private

            # locale

            def hello_ensure_thread_locale
              v = current_user.try(:locale)
              v ||= session['locale']
              v ||= hello_recommended_locale.to_s
              
              I18n.locale = session['locale'] = v
            end


      end
    end
  end
end
