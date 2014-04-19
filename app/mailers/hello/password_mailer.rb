module Hello
  class PasswordMailer < ActionMailer::Base
    default from: "from@example.com"

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.password_mailer.sign_up.subject
    #
    # def sign_up
    #   @greeting = "Hi"

    #   mail to: "to@example.org"
    # end

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.password_mailer.forgot.subject
    #
    def forgot(identity, url)
      @identity = identity
      @url      = url

      mail to: identity.email
    end

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.password_mailer.confirmation.subject
    #
    # def confirmation
    #   @greeting = "Hi"

    #   mail to: "to@example.org"
    # end
  end
end
