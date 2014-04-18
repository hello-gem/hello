require 'spec_helper'

module Hello
  describe Session do

    before(:each) do
      @session = Session.new
    end

    describe "validations" do
      it "presence of user and identity" do
        @session.valid?
        expect(@session.errors[:user]).to include "can't be blank"
        expect(@session.errors[:identity]).to include "can't be blank"
      end
    end
 

    describe "before validations, on creation" do
      it "auto attribution of user through identity" do
        @session.identity = Identity.new(strategy: Identity.password, user: User.create(name: 'James Pinto'))
        @session.save # trigger before_validation on creation
        expect(@session.errors[:user]).to     eq []
        expect(@session.errors[:identity]).to eq []
      end
    end


  end
end
