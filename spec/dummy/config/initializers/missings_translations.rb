
I18n.exception_handler = lambda do |_exception, locale, key, _options|
  if key.to_s != 'i18n.plural.rule'
    fail "missing translation: #{locale} - #{key}"
  end
end
