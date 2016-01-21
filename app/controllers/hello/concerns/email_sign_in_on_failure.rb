module Hello
  module Concerns
    module EmailSignInOnFailure

      def on_failure
        respond_to do |format|
          format.html { render action: 'index' }
          format.json { render json: @sign_in.errors, status: :unprocessable_entity }
        end
      end

    end
  end
end
