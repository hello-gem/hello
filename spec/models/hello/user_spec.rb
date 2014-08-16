require 'spec_helper'

module Hello
  describe User do
    before(:each) do
      @user = User.new
    end

    describe "validations" do
      it "presence of name" do
        @user.valid?
        # citi is only here because we need to test code customization, and this is how we are currently testing it
        expect(@user.errors.messages).to eq({:name=>["can't be blank"], :locale=>["can't be blank"], :city=>["can't be blank"]})
      end
    end

  end
end
