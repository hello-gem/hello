module Hello
  module Concerns
    module EmailSignUpOnFailure

      def on_failure
        respond_to do |format|
          format.html { render_classic_sign_up }
          format.json { render json: @sign_up.errors, status: :unprocessable_entity }
        end
      end

    end
  end
end
