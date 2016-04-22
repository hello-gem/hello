module Hello
  module Railsy
    module Helper
      def method_missing(method, *args, &block)
        # # http://candland.net/2012/04/17/rails-routes-used-in-an-isolated-engine/
        # puts "LOOKING FOR ROUTES #{method}"
        return super unless method.to_s.end_with?('_path', '_url')
        return super unless main_app.respond_to?(method)
        main_app.send(method, *args)
      end

      def respond_to?(method)
        return super unless method.to_s.end_with?('_path', '_url')
        return super unless main_app.respond_to?(method)
        true
      end
    end
  end
end

if defined? ActionView::Base
  ActionView::Base.class_eval do
    include Hello::Railsy::Helper
  end
end
