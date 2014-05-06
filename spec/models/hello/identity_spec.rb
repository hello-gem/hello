require 'spec_helper'

module Hello
  describe Identity do


    describe "username" do
      describe "validations" do
        it "presence" do
          identity = Identity.new
          identity.valid?
          expect(identity.username).not_to eq(nil)
        end

        it "uniqueness" do
          FactoryGirl.create(:classic_identity, username: 'james')
          identity = FactoryGirl.build(:classic_identity, username: 'james')
          identity.valid?
          expect(identity.errors[:username]).to eq ["already exists"]
        end

        it "#username_used_by_another?" do
          i1 = FactoryGirl.create(:classic_identity)
          i2 = FactoryGirl.build(:classic_identity, username: '')
          is_used_by_another = i2.username_used_by_another?(i1.username)
          expect(is_used_by_another).to eq(true)
        end

        it "format" do
          identity = FactoryGirl.build(:classic_identity)

          invalid_usernames = ["*****", "James!", "James@", "@James", "James?", "james#", "james$", "james%", "james&", "james*", "james("]
          invalid_usernames.each do |username|
            identity.username = username
            identity.valid?
            err = identity.errors[:username]
            expect(err).to eq(["is invalid"]), "'#{err}' when username is '#{username}'"
          end
          
          valid_usernames = ["james", "James", "JAMES", "James88", "88James", "88-james", "james_88"]
          valid_usernames.each do |username|
            identity.username = username
            identity.valid?
            err = identity.errors[:username]
            expect(err).to eq([]), "'#{err}' when username is '#{username}'"
          end

        end

      end

      it "#make_up_new_username" do
        identity = FactoryGirl.build(:classic_identity, username: '')
        a_username = identity.make_up_new_username
        expect(a_username.length).to eq(32)
        expect(identity.username).to eq('')
      end

    end




    describe "strategies" do
      describe "commmon aspects" do

        describe "validations" do
          it "presence" do
            identity = Identity.new
            identity.valid?
            expect(identity.errors[:strategy]).to include "can't be blank"
            expect(identity.errors[:user]).to     include "can't be blank"
          end

          it "inclusion" do
            identity = Identity.new
            identity.strategy = 'madeup'
            identity.valid?
            expect(identity.errors[:strategy]).to eq ["is not included in the list"]
          end
        end

      end





      describe "classic strategy" do

        before(:each) do
          @identity = Identity.classic.new
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
            a_user = User.create!(name: 'James Pinto', city: 'Brasilia')

            identity = Identity.classic.new(email: email, password: '1234', user: a_user)
            identity.save.should be_true

            identity = Identity.classic.new(email: email, password: '1111')
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
            expect(@identity.errors[:password]).to eq ["minimum of 4 characters"]

            @identity.password = '1' * 4
            @identity.valid?
            expect(@identity.errors[:password]).to be_empty

            @identity.password = '1' * 201
            @identity.valid?
            expect(@identity.errors[:password]).to eq ["maximum of 200 characters"]
          end
          
        end
      end
      
    end






  end
end
