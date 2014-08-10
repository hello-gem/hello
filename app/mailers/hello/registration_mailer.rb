module Hello
  class RegistrationMailer < ActionMailer::Base
    default from: "hello@example.com"

    def welcome(credential)
      @credential = credential
      @user     = credential.user

      mail to: credential.email
    end

    def confirm_email(credential, url)
      @credential = credential
      @user     = credential.user
      @url      = url

      mail to: credential.email
    end

    def forgot_password(credential, url)
      @credential = credential
      @user     = credential.user
      @url      = url

      mail to: credential.email
    end

  end
end
