module Hello
  module RequestManager
    class Factory

      def initialize(request)
        @request = request
      end

      def create
        klass.new(@request)
      end

      private

      def klass
        is_stateless? ? Stateless : Stateful
      end

      def is_stateless?
        has_host_api? || has_url_api?
      end

      def has_host_api?
        @request.host.starts_with?('api.')
      end

      def has_url_api?
        @request.fullpath.starts_with?('/api/')
      end
    end
  end
end
