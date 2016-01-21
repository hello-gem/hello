module Hello
  # invoked from config/initializers/hello.rb
  def self.configure
    yield(configuration)
  end

  # invoked internally
  def self.configuration
    @configuration ||= Rails.configuration.hello
  end

end
