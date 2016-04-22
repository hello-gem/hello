require_relative 'locales/locale_names'

module Hello
  def self.default_locale
    I18n.default_locale || 'en'
  end
end
