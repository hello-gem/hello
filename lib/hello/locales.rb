require_relative 'locales/locale_names'

module Hello
  def self.available_time_zones
    ActiveSupport::TimeZone.send(:zones_map).values.map(&:name)
  end

  def self.default_locale
    I18n.default_locale || 'en'
  end
end
