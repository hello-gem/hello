require 'spec_helper'

module Hello
  describe Identity do





    describe "strategies" do
      describe "commmon aspects" do

        describe "validations" do
          it "presence" do
            identity = Identity.new
            identity.valid?
            expect(identity.errors[:strategy]).to include "can't be blank"
          end

          it "inclusion" do
            identity = Identity.new
            identity.strategy = 'madeup'
            identity.valid?
            expect(identity.errors[:strategy]).to eq ["is not included in the list"]
          end
        end

      end





      describe "strategy-password" do

        before(:each) do
          @identity = Identity.new(strategy: Identity.password)
        end

        describe "email validations" do

          it "presence" do
            @identity.valid?
            @identity.errors[:email].should include "can't be blank"
          end

          it "format" do
            @identity.email = 'aaa'
            @identity.valid?
            @identity.errors[:email].should == ["does not appear to be valid"]

            @identity.email = 'email@hello.com'
            @identity.valid?
            @identity.errors[:email].should be_empty
          end

          it "uniqueness" do
            email = 'email@hello.com'

            identity = Identity.new(strategy: Identity.password, email: email, password: '1234')
            identity.save.should be_true

            identity = Identity.new(strategy: Identity.password, email: email, password: '1111')
            identity.valid?
            # identity.errors[:email].should == ["has already been taken"]
            identity.errors[:email].should == ["already exists"]
          end

        end

        describe "password validations" do
          
          it "presence" do
            @identity.valid?
            expect(@identity.errors[:password]).to include "can't be blank"
          end

          it "length" do
            @identity.password = '1' * 1
            @identity.valid?
            expect(@identity.errors[:password]).to eq ["pick a shorter password"]

            @identity.password = '1' * 4
            @identity.valid?
            expect(@identity.errors[:password]).to be_empty

            @identity.password = '1' * 201
            @identity.valid?
            expect(@identity.errors[:password]).to eq ["pick a longer password"]
          end
          
        end
      end
      
    end






  end
end
