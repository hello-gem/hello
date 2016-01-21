module Hello
  module Concerns
    module ResetPasswordOnFailure

      def on_failure
        render action: 'index'
      end

    end
  end
end
