module Hello
  module Locales
    def self.all
      @all ||= YAML.load(File.read(Hello.root.join('lib/data/locales.yml')))
    end
  end
end
