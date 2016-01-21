module Hello
  module Concerns
    module EmailSignUpOnFailure

      def on_failure
        respond_to do |format|
          format.html { render action: 'index' }
          format.json { render json: @sign_up.errors, status: :unprocessable_entity }
        end
      end

    end
  end
end
