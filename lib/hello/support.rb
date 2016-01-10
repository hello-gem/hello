module Hello
  def self.warning(s2)
    s1 = 'HELLO DEV WARNING:'.black.on_yellow.bold
    puts "#{s1} #{s2.yellow}"
  end
end
