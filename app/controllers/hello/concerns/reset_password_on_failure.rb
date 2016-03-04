module Hello
  module Concerns
    module ResetPasswordOnFailure

      def on_failure
        render_reset_form
      end

    end
  end
end
