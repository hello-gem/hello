module Hello

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :mailer_sender

    def initialize
      self.mailer_sender = 'hello@example.com'
    end

    def mailer_sender=(v)
      message_array = ValidatesEmailFormatOf.validate_email_format v.to_s
      raise StandardError.new(message_array.to_sentence) if message_array
      @mailer_sender=v
    end
    
  end
end