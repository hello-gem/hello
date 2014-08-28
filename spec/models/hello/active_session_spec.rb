require 'spec_helper'

module Hello
  describe ActiveSession do

    before(:each) do
      @active_session = ActiveSession.new
    end

    describe "validations" do
      it "presence of user and credential" do
        @active_session.valid?
        expect(@active_session.errors[:user]).to include "can't be blank"
        expect(@active_session.errors[:credential]).to include "can't be blank"
      end
    end
 

    describe "before validations, on creation" do
      it "auto attribution of user through credential" do
        @active_session.credential = FactoryGirl.create(:classic_credential)
        @active_session.save # trigger before_validation on creation
        expect(@active_session.errors[:user]).to     eq []
        expect(@active_session.errors[:credential]).to eq []
      end
    end

    describe "methods" do
      it "parsed_user_agent" do
        expect(@active_session.parsed_user_agent).to be_a(UserAgentParser::UserAgent)
      end
    end

  end
end
