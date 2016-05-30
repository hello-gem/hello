Hello.configure do |config|
  config.mailer_sender = 'hello@example.com'

  config.email_presence = true
  config.email_regex  = /\A[A-Z0-9._-]+@[A-Z0-9.-]+\.[A-Z0-9.-]+\z/i
  config.email_length = 4..250

  config.username_presence = true
  config.username_regex  = /\A[a-z0-9_-]+\z/i
  config.username_length = 4..32

  config.password_presence = true
  config.password_regex  = /\A[a-z0-9]+\z/i
  config.password_length = 4..250

  config.classic_sign_up_disabled = false # {reason: "standard maintenance", until: "3PM"}
  config.classic_sign_up_fields = %w(username time_zone locale name city)

  config.simple_encryptor  = Hello::Encryptors::MD5.new
  config.complex_encryptor = Hello::Encryptors::BCrypt.new

  config.locales    = %w(en es fr pl pt-BR zh-CN)
  config.time_zones = Hello::TimeZones.all

  config.sudo_expires_in = 10.minutes

end
