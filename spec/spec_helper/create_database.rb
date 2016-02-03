puts "RUBY  #{RUBY_VERSION}.#{RUBY_PATCHLEVEL} #{RUBY_RELEASE_DATE} (#{RUBY_PLATFORM})".magenta
puts "RAILS #{Rails::VERSION::STRING}".magenta
# database: ":memory:"
puts 'loading sqlite schema in memory'
load "#{Rails.root}/db/schema.rb"
