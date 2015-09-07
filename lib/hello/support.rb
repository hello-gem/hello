module Hello

  def self.available_time_zones
    ActiveSupport::TimeZone.send(:zones_map).values.map(&:name)
  end

  def self.warning(s2)
    s1 = "HELLO DEV WARNING:".black.on_yellow.bold
    puts "#{s1} #{s2.yellow}"
  end

end