module Hello
  class ImpersonateEntity < AbstractEntity

    def initialize(credential)
      @credential = credential
    end

    def success_message(extra={})
      super(name: @credential.user.name)
    end

  end
end