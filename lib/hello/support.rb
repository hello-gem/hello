module Hello

  def self.available_time_zones
    ActiveSupport::TimeZone.send(:zones_map).values.map(&:name)
  end

  def self.encrypt_token(plain_text_string)
    Digest::MD5.hexdigest(plain_text_string)
  end

  def self.is_this_rails_4_0?
    ::Rails.version =~ /4.0/
  end

end