require 'spec_helper'

module Hello
  describe Credential do


    describe "username" do
      describe "validations" do
        it "presence" do
          credential = Credential.new
          credential.valid?
          expect(credential.username).not_to eq(nil)
        end

        it "uniqueness" do
          FactoryGirl.create(:classic_credential, username: 'james')
          credential = FactoryGirl.build(:classic_credential, username: 'james')
          credential.valid?
          expect(credential.errors[:username]).to eq ["already exists"]
        end

        it "#username_used_by_another?" do
          i1 = FactoryGirl.create(:classic_credential)
          i2 = FactoryGirl.build(:classic_credential, username: '')
          is_used_by_another = i2.username_used_by_another?(i1.username)
          expect(is_used_by_another).to eq(true)
        end

        it "format" do
          credential = FactoryGirl.build(:classic_credential)

          invalid_usernames = ["*****", "James!", "James@", "@James", "James?", "james#", "james$", "james%", "james&", "james*", "james("]
          invalid_usernames.each do |username|
            credential.username = username
            credential.valid?
            err = credential.errors[:username]
            expect(err).to eq(["is invalid"]), "'#{err}' when username is '#{username}'"
          end
          
          valid_usernames = ["james", "James", "JAMES", "James88", "88James", "88-james", "james_88"]
          valid_usernames.each do |username|
            credential.username = username
            credential.valid?
            err = credential.errors[:username]
            expect(err).to eq([]), "'#{err}' when username is '#{username}'"
          end

        end

      end

      it "#make_up_new_username" do
        credential = FactoryGirl.build(:classic_credential, username: '')
        a_username = credential.make_up_new_username
        expect(a_username.length).to eq(32)
        expect(credential.username).to eq('')
      end

    end




    describe "strategies" do
      describe "commmon aspects" do

        describe "validations" do
          it "presence" do
            credential = Credential.new
            credential.valid?
            expect(credential.errors[:strategy]).to include "can't be blank"
            expect(credential.errors[:user]).to     include "can't be blank"
          end

          it "inclusion" do
            credential = Credential.new
            credential.strategy = 'madeup'
            credential.valid?
            expect(credential.errors[:strategy]).to eq ["is not included in the list"]
          end
        end

      end





      describe "classic strategy" do

        before(:each) do
          @credential = Credential.classic.new
        end

        describe "email validations" do

          it "presence" do
            @credential.valid?
            @credential.errors[:email].should include "can't be blank"
          end

          it "format" do
            @credential.email = 'aaa'
            @credential.valid?
            @credential.errors[:email].should == ["does not appear to be valid"]

            @credential.email = 'email@hello.com'
            @credential.valid?
            @credential.errors[:email].should be_empty
          end

          it "uniqueness" do
            email = 'email@hello.com'
            a_user = FactoryGirl.create(:user, name: 'James Pinto', city: 'Brasilia')

            credential = FactoryGirl.build(:classic_credential, email: email, password: '1234', user: a_user)
            credential.save.should be_true

            credential = FactoryGirl.build(:classic_credential, email: email, password: '1111')
            credential.valid?
            # credential.errors[:email].should == ["has already been taken"]
            credential.errors[:email].should == ["already exists"]
          end

        end

        describe "password validations" do
          
          it "presence" do
            @credential.valid?
            expect(@credential.errors[:password]).to include "can't be blank"
          end

          it "length" do
            @credential.password = '1' * 1
            @credential.valid?
            expect(@credential.errors[:password]).to eq ["minimum of 4 characters"]

            @credential.password = '1' * 4
            @credential.valid?
            expect(@credential.errors[:password]).to be_empty

            @credential.password = '1' * 201
            @credential.valid?
            expect(@credential.errors[:password]).to eq ["maximum of 200 characters"]
          end
          
        end
      end
      
    end






  end
end
