module Hello
  module Manager
    class RequestManagerFactory
      def initialize(request)
        @request = request
      end

      def create
        klass.new(@request)
      end

      private

      def klass
        if is_stateless?
          StatelessRequestManager
        else
          StatefulRequestManager
        end
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
