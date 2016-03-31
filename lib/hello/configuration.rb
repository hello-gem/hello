module Hello
  # invoked from config/initializers/hello.rb
  def self.configure
    yield(configuration)
  end

  # invoked internally
  def self.configuration
    Rails.configuration.hello ||= ActiveSupport::OrderedOptions.new
  end

end
