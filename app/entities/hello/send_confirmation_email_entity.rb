module Hello
  class SendConfirmationEmailEntity < AbstractEntity

    attr_reader :controller, :credential

    def initialize(controller, credential)
      @controller = controller
      @credential = credential
    end

    def deliver
      token = credential.reset_verifying_token!
      check_token!(token)
      url   = controller.confirm_email_url(credential, token)
      mail  = Hello::RegistrationMailer.confirm_email(credential, url)
      mail.deliver
    end

    def success_message(extra={})
      super(email: credential.email)
    end

    private

    def check_token!(unencrypted_token)
      raise "no match" unless credential.verifying_token_is?(unencrypted_token)
    end

  end
end
