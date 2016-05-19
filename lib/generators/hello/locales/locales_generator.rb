require 'hello'

class Hello::LocalesGenerator < Rails::Generators::Base
  source_root Hello::ROOT

  argument :selected_locales, type: :array, default: [], banner: 'lang1 [lang2] [lang3]'

  def copy_locales
    case
    when selected_locales == []
      puts_usage
      puts
    when selected_locales == ['all']
      copy_them(available_locales)
    when missing_locales.any?
      puts_usage
      puts_matching
      puts_missing
      puts
    else
      copy_them(matching_locales)
    end
  end


  protected

  def copy_them(locales)
    locales.sort.each do |l|
      copy_file "config/locales/hello.#{l}.yml"
    end
  end

  def puts_usage
    puts
    puts "Usage:".light_yellow
    puts "  rails generate hello:locales all"
    puts "  rails generate hello:locales #{available_locales.sort.join(' ')}"
  end

  def puts_missing
    puts
    puts "Missing:".light_red
    puts "  rails generate hello:locales #{missing_locales.sort.join(' ')}"
  end

  def puts_matching
    puts
    puts "Matching:".light_green
    puts "  rails generate hello:locales #{matching_locales.sort.join(' ')}"
  end

  def matching_locales
    selected_locales & available_locales
  end

  def missing_locales
    selected_locales - available_locales
  end

  def available_locales
    Dir[Hello::ROOT.join('config', 'locales', '**', '*.yml')].map { |s| s.split('.')[-2] }
  end
end
