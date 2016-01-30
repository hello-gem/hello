module Hello
  module Concerns
    module UpdateProfileOnFailure

      def on_failure
        render action: 'show'
      end

    end
  end
end
