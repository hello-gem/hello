module Hello
  module RailsController
    class RestrictByRole

      def initialize(controller)
        @controller = controller
      end

      def kick(*roles)
        to_home_page if current_user.in_any_role?(roles)
      end

      def dont_kick(*roles)
        to_home_page if not current_user.in_any_role?(roles)
      end

      private

      def current_user
        @controller.current_user || ::User.new(role: 'guest')
      end

      def to_home_page
        if current_user.guest?
          to_sign_in
        elsif current_user.onboarding?
          to_onboarding
        else
          to_root
        end
      end

      def to_root
        respond_to do |format|
          format.html { redirect_to '/' }
          format.json do
            data   = { 'message' => 'Access Denied.' }
            status = :forbidden # 403
            render json: data, status: status
          end
        end
      end

      def to_sign_in
        respond_to do |format|
          format.html do
            hello_store_url_on_session!
            redirect_to hello.sign_in_path
          end
          format.json do
            data   = { 'message' => 'An active access token must be used to query information about the current user.' }
            status = :unauthorized # 401
            render json: data, status: status
          end
        end
      end

      def to_onboarding
        respond_to do |format|
          format.html { redirect_to '/onboarding' }
          format.json do
            data   = { 'message' => 'Access Denied, visit /onboarding and complete your registration.' }
            status = :forbidden # 403
            render json: data, status: status
          end
        end
      end

      def method_missing(method, *args, &block)
        if @controller.respond_to?(method)
          @controller.send(method, *args, &block)
        else
          super
        end
      end

    end
  end
end
