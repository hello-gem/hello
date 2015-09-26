require 'spec_helper'

module Hello
  describe Access do

    it "validations" do
      subject.valid?

      expect(subject.errors.messages).to eq({
        :user=>["can't be blank"],
        :user_agent_string=>["can't be blank"],
      })
    end
 
    describe "methods" do
      it "parsed_user_agent" do
        expect(subject.parsed_user_agent).to be_a(UserAgentParser::UserAgent)
      end
    end

  end
end
