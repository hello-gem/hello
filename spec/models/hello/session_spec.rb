require 'spec_helper'

module Hello
  describe Session do

    before(:each) do
      @session = Session.new
    end

    describe "validations" do
      it "presence of user and credential" do
        @session.valid?
        expect(@session.errors[:user]).to include "can't be blank"
        expect(@session.errors[:credential]).to include "can't be blank"
      end
    end
 

    describe "before validations, on creation" do
      it "auto attribution of user through credential" do
        @session.credential = FactoryGirl.create(:classic_credential)
        @session.save # trigger before_validation on creation
        expect(@session.errors[:user]).to     eq []
        expect(@session.errors[:credential]).to eq []
      end
    end


  end
end
