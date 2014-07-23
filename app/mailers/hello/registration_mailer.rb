module Hello
  class RegistrationMailer < ActionMailer::Base
    default from: "hello@example.com"

    # def welcome
    #   @greeting = "Hi"

    #   mail to: "to@example.org"
    # end

    # def confirm_email
    #   @greeting = "Hi"

    #   mail to: "to@example.org"
    # end

    def forgot_password(credential, url)
      @credential = credential
      @user     = credential.user
      @url      = url

      mail to: credential.email
    end

  end
end
