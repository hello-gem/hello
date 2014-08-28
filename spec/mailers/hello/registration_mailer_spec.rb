require "spec_helper"

module Hello
  describe RegistrationMailer do
    let(:credential) { create(:classic_credential) }

    describe "welcome" do
      let(:mail) { RegistrationMailer.welcome(credential, "THE_PASSWORD") }

      it "renders the headers" do
        expect(mail.subject).to eq("Welcome to our website")
        expect(mail.to).to eq([credential.email])
        expect(mail.from).to eq(["hello@example.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("Hello #{credential.user.name},")
        expect(mail.body.encoded).to match("Welcome")
      end
    end

    describe "confirm_email" do
      let(:mail) { RegistrationMailer.confirm_email(credential, "THE_URL") }

      it "renders the headers" do
        expect(mail.subject).to eq("Confirm This Email")
        expect(mail.to).to eq([credential.email])
        expect(mail.from).to eq(["hello@example.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("Hello #{credential.user.name},")
        expect(mail.body.encoded).to match(">THE_URL</a>")
      end
    end

    describe "forgot_password" do
      let(:mail) { RegistrationMailer.forgot_password(credential, "THE_URL") }

      it "renders the headers" do
        expect(mail.subject).to eq("Reset Password Instructions")
        expect(mail.to).to eq([credential.email])
        expect(mail.from).to eq(["hello@example.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("Hello #{credential.user.name},")
        expect(mail.body.encoded).to match(">THE_URL</a>")
      end
    end


  end
end
