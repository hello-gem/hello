module Hello
  class UpdateClassicCredentialEntity < AbstractEntity

    def initialize(action_name)
      @action_name = action_name
    end

    def success_message(extra={})
      super(field: @action_name)
    end

    def alert_message(extra={})
      super(field: @action_name)
    end
    
  end
end