module Hello
  module Concerns
    module ClassicSignInOnFailure

      def on_failure
        respond_to do |format|
          format.html { render_classic_sign_in }
          format.json { render json: @sign_in.errors, status: :unprocessable_entity }
        end
      end

    end
  end
end
