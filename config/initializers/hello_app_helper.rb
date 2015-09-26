# http://candland.net/2012/04/17/rails-routes-used-in-an-isolated-engine/
module Hello
  module ApplicationHelper

    def method_missing method, *args, &block
      # puts "LOOKING FOR ROUTES #{method}"
      return super if not method.to_s.end_with?('_path', '_url')
      return super if not main_app.respond_to?(method)
      main_app.send(method, *args)
    end

    def respond_to?(method)
      return super if not method.to_s.end_with?('_path', '_url')
      return super if not main_app.respond_to?(method)
      true
    end

  end
end
