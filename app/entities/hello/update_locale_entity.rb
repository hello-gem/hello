module Hello
  class UpdateLocaleEntity < AbstractEntity

    def initialize(locale)
      @locale = locale
    end

    def locale
      locale_if_available || Hello.default_locale
    end

    def success_message(extra={})
      super(locale_name: I18n.t('hello.others.locale'))
    end

    private

    def locale_if_available
      ([@locale] & Hello.available_locales).first
    end

  end
end