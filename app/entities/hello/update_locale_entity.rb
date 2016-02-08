module Hello
  class UpdateLocaleEntity < AbstractEntity
    def initialize(locale)
      @locale = locale
    end

    def locale
      locale_if_available || Hello.default_locale
    end

    def success_message(_extra = {})
      super(locale_name: current_locale_name)
    end

    private

    def locale_if_available
      ([@locale] & locales).first
    end

    def locales
      Hello.configuration.locales
    end

    def current_locale_name
      I18n.t('hello.locale_name')
    end
  end
end
