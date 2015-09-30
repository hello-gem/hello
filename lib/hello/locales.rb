require_relative 'locales/locale_names'

module Hello

  def self.available_time_zones
    ActiveSupport::TimeZone.send(:zones_map).values.map(&:name)
  end

  def self.available_locales
    # yes, it would be better if this was not hardcoded
    # but we need this list somewhere so we can point out when a language is not supported by this gem
    ['en', 'pt-BR', 'es']
  end

  def self.default_locale
    I18n.default_locale || 'en'
  end

end
