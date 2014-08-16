
I18n.exception_handler = lambda do |exception, locale, key, options|
  if key.to_s != 'i18n.plural.rule'
    raise "missing translation: #{locale} - #{key}"
  end
end
