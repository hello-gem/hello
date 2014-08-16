module Hello
  class NotAuthenticated < StandardError
    def message
      I18n.t "hello.exceptions.not_authenticated.message"
    end

    def alert_message
      I18n.t "hello.exceptions.not_authenticated.alert"
    end
  end

  class JsonNotSupported < StandardError
    def message
      "add your locale as a 'param' or 'header' instead"
    end
  end
end