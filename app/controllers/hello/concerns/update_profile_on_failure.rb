module Hello
  module Concerns
    module UpdateProfileOnFailure

      def on_failure
        render action: 'index'
      end

    end
  end
end
