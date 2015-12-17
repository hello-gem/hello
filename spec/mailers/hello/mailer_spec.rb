require "spec_helper"

module Hello
  describe Mailer do
    let(:email_credential) { create(:email_credential, user: create(:user, name: "John O'Cornel")) }
    let(:name) { "John O&#39;Cornel" }

    describe "welcome" do
      let(:mail) { Mailer.welcome(email_credential, "THE_PASSWORD") }

      it "renders the headers" do
        expect(mail.subject).to eq("Welcome to our website")
        expect(mail.to).to eq([email_credential.email])
        expect(mail.from).to eq(["hello@example.com"])
      end

      it "renders the body" do
        expect(mail.body.to_s).to match("Hello #{name},")
        expect(mail.body.to_s).to match("Welcome")
      end
    end

    describe "confirm_email" do
      let(:mail) { Mailer.confirm_email(email_credential, "THE_URL") }

      it "renders the headers" do
        expect(mail.subject).to eq("Confirm This Email")
        expect(mail.to).to eq([email_credential.email])
        expect(mail.from).to eq(["hello@example.com"])
      end

      it "renders the body" do
        expect(mail.body.to_s).to match("Hello #{name},")
        expect(mail.body.to_s).to match(">THE_URL</a>")
      end
    end

    describe "forgot_password" do
      let(:mail) { Mailer.forgot_password(email_credential, "THE_URL") }

      it "renders the headers" do
        expect(mail.subject).to eq("Reset Password Instructions")
        expect(mail.to).to eq([email_credential.email])
        expect(mail.from).to eq(["hello@example.com"])
      end

      it "renders the body" do
        expect(mail.body.to_s).to match("Hello #{name},")
        expect(mail.body.to_s).to match(">THE_URL</a>")
      end
    end


  end
end
