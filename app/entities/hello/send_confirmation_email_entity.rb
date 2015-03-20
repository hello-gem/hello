module Hello
  class SendConfirmationEmailEntity < AbstractEntity

    attr_reader :controller, :credential

    def initialize(controller, credential)
      @controller = controller
      @credential = credential
    end

    def deliver
      token = credential.reset_email_token!
      check_token!(token)
      url   = controller.confirm_email_url(credential, token)
      mail  = Hello::RegistrationMailer.confirm_email(credential, url)
      mail.deliver
    end

    def success_message(extra={})
      super(email: credential.email)
    end

    private

    def check_token!(token)
      e = ConfirmEmailEntity.new(credential)
      raise "no match" unless e.validate_token(token)
    end

  end
end