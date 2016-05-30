module Hello
  module Registration
    class ClassicSignUpController < ApplicationController
      include Hello::Concerns::ClassicSignUpOnSuccess
      include Hello::Concerns::ClassicSignUpOnFailure

      dont_kick_people

      before_action do
        @sign_up = Hello::Business::Registration::SignUp.new
      end

      # GET /hello/sign_up
      def index
        render_classic_sign_up
      end

      # GET /hello/sign_up/widget
      def widget
        render 'hello/registration/classic_sign_up/widget', layout: false
      end

      # POST /hello/sign_up
      def create
        if classic_sign_up_disabled
          _create_disabled
        else
          _create_enabled
        end
      end

      # GET /hello/sign_up/disabled
      def disabled
        render_classic_sign_up
      end

      protected

      def render_classic_sign_up
        render 'hello/registration/classic_sign_up/index'
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
        if classic_sign_up_disabled.is_a?(Hash)
          classic_sign_up_disabled.each do |k, v|
            @sign_up.errors[k] << Array(v).flatten
          end
        end
        on_failure
      end
    end
  end
end
