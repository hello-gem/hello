module Hello
  module Modules
    module EmailSignUpDummy
      include Hello::Modules::EmailSignUp

      def fields
        %w(name username password time_zone locale city)
      end
    end
  end
end
