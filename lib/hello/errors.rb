module Hello
  module Errors
    class Error < StandardError
    end

    class JsonNotSupported < Error
      def message
        "add your locale as a 'param' or 'header' instead"
      end
    end
  end
end
