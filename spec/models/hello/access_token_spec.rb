require 'spec_helper'

module Hello
  describe AccessToken do

    let(:access_token) { AccessToken.new }

    it "validations" do
      access_token.valid?

      expect(access_token.errors.messages).to eq({
        :user=>["can't be blank"],
        :user_agent_string=>["can't be blank"],
      })
    end
 
    describe "methods" do
      it "parsed_user_agent" do
        expect(access_token.parsed_user_agent).to be_a(UserAgentParser::UserAgent)
      end
    end

  end
end
