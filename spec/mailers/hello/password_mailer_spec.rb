require "spec_helper"

module Hello
  describe PasswordMailer do
    describe "sign_up" do
      let(:mail) { PasswordMailer.sign_up }

      it "renders the headers" do
        expect(mail.subject).to eq("Sign up")
        expect(mail.to).to eq(["to@example.org"])
        expect(mail.from).to eq(["from@example.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("Hi")
      end
    end

    describe "forgot" do
      let(:mail) { PasswordMailer.forgot }

      it "renders the headers" do
        expect(mail.subject).to eq("Forgot")
        expect(mail.to).to eq(["to@example.org"])
        expect(mail.from).to eq(["from@example.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("Hi")
      end
    end

    describe "confirmation" do
      let(:mail) { PasswordMailer.confirmation }

      it "renders the headers" do
        expect(mail.subject).to eq("Confirmation")
        expect(mail.to).to eq(["to@example.org"])
        expect(mail.from).to eq(["from@example.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("Hi")
      end
    end

  end
end
