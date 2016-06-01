module Hello
  module Registration
    # you really should be overriding concerns instead of this file
    class SignUpController < ApplicationController
      include Hello::Concerns::Registration::SignUp

      dont_kick_people

      before_action do
        @sign_up = Hello::Business::Registration::SignUp.new
      end

      # GET /hello/sign_up
      def index
        render_sign_up
      end

      # GET /hello/sign_up/widget
      def widget
        render 'hello/registration/sign_up_widget', layout: false
      end

      # POST /hello/sign_up
      def create
        if sign_up_disabled
          _create_disabled
        else
          _create_enabled
        end
      end

      # GET /hello/sign_up/disabled
      def disabled
        render_sign_up
      end

      protected

      def render_sign_up
        render 'hello/registration/sign_up'
      end

      def _create_enabled
        if @sign_up.register(params.require(:sign_up))
          flash[:notice] = @sign_up.success_message
          on_success
        else
          on_failure
        end
      end

      def _create_disabled
        @sign_up.errors[:base] << "Email Registration is temporarily disabled"
        if sign_up_disabled.is_a?(Hash)
          sign_up_disabled.each do |k, v|
            @sign_up.errors[k] << Array(v).flatten
          end
        end
        on_failure
      end
    end
  end
end
