module Hello
  class Mailer < ActionMailer::Base
    default from: Hello.configuration.mailer_sender

    def welcome(email_credential, password)
      @user     = email_credential.user
      @password = password

      mail to: email_credential.email
    end

    def confirm_email(email_credential, url)
      @user = email_credential.user
      @url  = url

      mail to: email_credential.email
    end

    def forgot_password(email_credential, url)
      @user = email_credential.user
      @url  = url

      mail to: email_credential.email
    end

  end
end
