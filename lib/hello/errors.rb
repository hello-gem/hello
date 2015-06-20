module Hello

  class JsonNotSupported < StandardError
    def message
      "add your locale as a 'param' or 'header' instead"
    end
  end

end