module Hello
  class PasswordMailer < ActionMailer::Base
    default from: "hello@example.com"

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.hello.password_mailer.sign_up.subject
    #
    # def sign_up
    #   @greeting = "Hi"

    #   mail to: "to@example.org"
    # end

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.hello.password_mailer.confirmation.subject
    #
    # def confirmation
    #   @greeting = "Hi"

    #   mail to: "to@example.org"
    # end

    def forgot(credential, url)
      @credential = credential
      @user     = credential.user
      @url      = url

      mail to: credential.email
    end

  end
end
