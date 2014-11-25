require 'hello/locales/locale_names'

module Hello

  def self.available_locales
    # yes, it would be better if this was not hardcoded
    # but we need this list somewhere so we can point out when a language is not supported by this gem
    ['en', 'pt-BR', 'es']
  end

end
