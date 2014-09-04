module Hello
  class SendConfirmationEmailEntity < AbstractEntity

    attr_reader :controller, :credential

    def initialize(controller, credential)
      @controller = controller
      @credential = credential
    end

    def deliver
      token = credential.reset_email_token!
      url   = controller.classic_confirm_email_token_url(token)
      Hello::RegistrationMailer.confirm_email(credential, url).deliver!
    end

    def success_message(extra={})
      super(email: credential.email)
    end

    def info_1_message
      t("info_1", email: credential.email)
    end

    def info_2_message
      t("info_2")
    end

  end
end