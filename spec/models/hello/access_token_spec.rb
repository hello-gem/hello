require 'spec_helper'

module Hello
  describe AccessToken do

    before(:each) do
      @access_token = AccessToken.new
    end

    describe "validations" do
      it "presence of user and credential" do
        @access_token.valid?
        expect(@access_token.errors[:user]).to include "can't be blank"
        expect(@access_token.errors[:credential]).to include "can't be blank"
      end
    end
 

    describe "before validations, on creation" do
      it "auto attribution of user through credential" do
        @access_token.credential = FactoryGirl.create(:classic_credential)
        @access_token.save # trigger before_validation on creation
        expect(@access_token.errors[:user]).to     eq []
        expect(@access_token.errors[:credential]).to eq []
      end
    end

    describe "methods" do
      it "parsed_user_agent" do
        expect(@access_token.parsed_user_agent).to be_a(UserAgentParser::UserAgent)
      end
    end

  end
end
