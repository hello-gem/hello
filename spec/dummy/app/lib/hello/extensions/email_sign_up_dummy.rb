module Hello
  module Extensions
    module EmailSignUpDummy
      include Hello::Extensions::EmailSignUp

      def fields
        %w(name username time_zone locale city)
      end
    end
  end
end
