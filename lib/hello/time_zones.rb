module Hello
  module TimeZones
    def self.all
      ActiveSupport::TimeZone.send(:zones_map).values.map(&:name)
    end
  end
end
