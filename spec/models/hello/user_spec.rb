require 'spec_helper'

module Hello
  describe User do
    before(:each) do
      @user = User.new
    end

    describe "validations" do
      it "presence of name" do
        @user.valid?
        expect(@user.errors[:name]).to include "can't be blank"
      end
    end
 

    describe "default value" do
      it "role" do
        expect(@user.role).to eq "user"
      end
    end

  end
end
