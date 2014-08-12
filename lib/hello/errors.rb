module Hello
  class NotAuthenticated < StandardError
    def message
      I18n.t "hello.exceptions.not_authenticated.message"
    end

    def alert_message
      I18n.t "hello.exceptions.not_authenticated.alert"
    end
  end
end