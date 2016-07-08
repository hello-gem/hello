module Hello
  module Business
    module Registration
      class SignUp < Base
        attr_reader :user

        def initialize
          init_user
        end

        def register(attrs)
          init_user(attrs)

          user.save.tap do
            merge_errors_for(@email_credential)
            merge_errors_for(@password_credential)
            errors.delete(:email_credentials)
            errors.delete(:password_credentials)
          end
        end

        # errors.added? DOES NOT WORK when the validation was given a custom message :)
        def email_taken?
          @email_credential && @email_credential.errors.added?(:email, :taken)
        end

        # errors.added? DOES NOT WORK when the validation was given a custom message :)
        def username_taken?
          errors.added?(:username, :taken)
        end

        def method_missing(method_name, *args, &block)
          user.send(method_name)
        end

        private

        def init_user(attrs={})
          attrs.reverse_merge!(defaults)
          @user = User.new(attrs)
          @email_credential = user.email_credentials.first
          @password_credential = user.password_credentials.first
          @errors = user.errors
        end

        def defaults
          {
            locale:    I18n.locale.to_s,
            time_zone: Time.zone.name,
            email: '',
            password: '',
          }
        end

        def merge_errors_for(model)
          if model
            model.valid?
            model.errors.each do |k, v|
              errors.add(k, v)
            end
          end
        end

      end
    end
  end
end
