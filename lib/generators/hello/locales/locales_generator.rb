require 'hello'

class Hello::LocalesGenerator < Rails::Generators::Base
  source_root File.expand_path('../../../../../', __FILE__)

  argument :locale, type: :string, default: false

  def copy_locales
    if argument_match_any_locale?
      copy_file "config/locales/hello.#{locale}.yml",
                "config/locales/hello.#{locale}.yml"
    elsif copy_all_locales?
      available_locales.each do |locale|
        copy_file "config/locales/hello.#{locale}.yml",
                  "config/locales/hello.#{locale}.yml"
      end
    else
      puts "Available options are: #{available_locales.join(', ')}"
      puts "You can also use 'all' to copy all locales"
    end
  end

  protected

  def argument_match_any_locale?
    return true if available_locales.include? locale
  end

  def available_locales
    Dir[Hello::ROOT.join('config', 'locales', '**', '*.yml')].map { |s| s.split('.')[-2] }
  end

  def copy_all_locales?
    return true if locale == 'all'
  end
end
