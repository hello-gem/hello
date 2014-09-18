require 'spec_helper'

module Hello
  describe Configuration do
    describe "#mailer_sender" do
      it "has a default value" do
        config = Configuration.new
        expect(config.mailer_sender).to eq("hello@example.com")
      end
    end

    describe "#mailer_sender=" do
      it "cannot set invalid value" do
        config = Configuration.new
        expect { config.mailer_sender = 7 }.to raise_error(ArgumentError, "does not appear to be a valid e-mail address")
      end

      it "can set valid value" do
        config = Configuration.new
        config.mailer_sender = "donotreply@example.com"
        expect(config.mailer_sender).to eq("donotreply@example.com")
      end
    end
  end
end