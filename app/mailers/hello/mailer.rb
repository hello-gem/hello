module Hello
  class Mailer < ActionMailer::Base
    default from: Hello.configuration.mailer_sender

    def welcome(email, user, password)
      @user     = user
      @password = password

      mail to: email
    end

    def confirm_email(email, user, url)
      @user = user
      @url  = url

      mail to: email
    end

    def forgot_password(email, user, url)
      @user = user
      @url  = url

      mail to: email
    end
  end
end
