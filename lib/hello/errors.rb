module Hello

  class AccessDenied < StandardError
  end


      class NotAuthenticated < AccessDenied
        def message
          I18n.t "hello.exceptions.not_authenticated.message"
        end

        def alert_message
          I18n.t "hello.exceptions.not_authenticated.alert"
        end
      end

      class Authenticated < AccessDenied
        def message
          I18n.t "hello.exceptions.authenticated.message"
        end

        def alert_message
          I18n.t "hello.exceptions.authenticated.alert"
        end
      end

      class RoleError < AccessDenied
        attr_reader :role

        def initialize(role)
          @role = role
          super(message)
        end
      end

          class NotAuthorizedMustBe < RoleError
            def message
              I18n.t "hello.exceptions.not_authorized.must_be.#{role}.message"
            end

            def alert_message
              I18n.t "hello.exceptions.not_authorized.must_be.#{role}.alert"
            end
          end

          class NotAuthorizedCannotBe < RoleError
            def message
              I18n.t "hello.exceptions.not_authorized.cannot_be.#{role}.message"
            end

            def alert_message
              I18n.t "hello.exceptions.not_authorized.cannot_be.#{role}.alert"
            end
          end

  class JsonNotSupported < StandardError
    def message
      "add your locale as a 'param' or 'header' instead"
    end
  end

end