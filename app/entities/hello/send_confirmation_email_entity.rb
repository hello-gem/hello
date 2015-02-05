module Hello
  class SendConfirmationEmailEntity < AbstractEntity

    attr_reader :controller, :credential

    def initialize(controller, credential)
      @controller = controller
      @credential = credential
    end

    def deliver
      token = credential.reset_email_token!
      url   = controller.confirm_token_credential_url(credential, token)
      Hello::RegistrationMailer.confirm_email(credential, url).deliver
    end

    def success_message(extra={})
      super(email: credential.email)
    end

  end
end