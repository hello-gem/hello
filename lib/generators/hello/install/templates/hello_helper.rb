module HelloHelper

  # Please take one of two actions
  # 1. Add gem 'nav_lynx' to your Gemfile and remove this file
  # 2. edit partial 'views/hello/shared/_settings' and replace `nav_link_to` for `link_to`
  def nav_link_to(*args)
    if defined?(NavLYNX)
      super
    else
      puts "#{__FILE__}"
      args.pop
      link_to(*args)
    end
  end

end
