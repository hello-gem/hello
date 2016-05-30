module Hello
  module RequestManager

    def self.create(request)
      Factory.new(request).create
    end

    autoload :Factory,   'hello/request_manager/factory'
    autoload :Abstract,  'hello/request_manager/abstract'
    autoload :Stateless, 'hello/request_manager/stateless'
    autoload :Stateful,  'hello/request_manager/stateful'

  end
end
