
I18n.exception_handler = lambda do |exception, locale, key, options|
  raise "missing translation: #{key}"
end
