require "spec_helper"

module Hello
  describe RegistrationMailer do
    let(:credential) { create(:classic_credential, user: create(:user, name: "John O'Cornel")) }
    let(:name) { "John O&#39;Cornel" }

    describe "welcome" do
      let(:mail) { RegistrationMailer.welcome(credential, "THE_PASSWORD") }

      it "renders the headers" do
        expect(mail.subject).to eq("Welcome to our website")
        expect(mail.to).to eq([credential.email])
        expect(mail.from).to eq(["hello@example.com"])
      end

      it "renders the body" do
        expect(mail.body.to_s).to match("Hello #{name},")
        expect(mail.body.to_s).to match("Welcome")
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
        expect(mail.body.to_s).to match("Hello #{name},")
        expect(mail.body.to_s).to match(">THE_URL</a>")
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
        expect(mail.body.to_s).to match("Hello #{name},")
        expect(mail.body.to_s).to match(">THE_URL</a>")
      end
    end


  end
end
