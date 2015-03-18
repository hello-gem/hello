module Hello
  class UpdateFieldEntity < AbstractEntity

    def initialize(field)
      @field = field
    end

    def success_message(extra={})
      super(field: @field)
    end

    def alert_message(extra={})
      super(field: @field)
    end
    
  end
end