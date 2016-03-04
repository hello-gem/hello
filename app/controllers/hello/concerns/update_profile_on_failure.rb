module Hello
  module Concerns
    module UpdateProfileOnFailure

      def on_failure
        render_edit_profile
      end

    end
  end
end
