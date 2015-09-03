module Hello

  def self.available_time_zones
    ActiveSupport::TimeZone.send(:zones_map).values.map(&:name)
  end

  def self.encrypt_token(plain_text_string)
    Digest::MD5.hexdigest(plain_text_string)
  end

  def self.warning(s2)
    s1 = "HELLO DEV WARNING:".black.on_yellow.bold
    puts "#{s1} #{s2.yellow}"
  end

end