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

    describe "methods" do
      it "#device_name" do
        pending "TODO: extract a device name from a user_agent"
        # actual
        # Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:27.0) Gecko/20100101 Firefox/27.0
        # Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/537.75.14
        # Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36

        # expect
        # Mac OS X - Firefox
        # Mac OS X - Chrome
        # Mac OS X - Safari
      end
      
    end


  end
end
