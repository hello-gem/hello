module Hello
  module Utils

    autoload :DeviceName, 'hello/utils/device_name'

    def self.trailing_options(args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      [options, args]
    end
  end
end
