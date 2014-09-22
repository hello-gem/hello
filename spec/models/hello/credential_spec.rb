require 'spec_helper'

module Hello
  describe Credential do

    it "validations" do
      model = Credential.new
      model.valid?
      expect(model.errors.messages).to eq({
        :user=>["can't be blank"],
        :strategy=>["can't be blank", "is not included in the list"],
        :username=>["is invalid", "minimum of 4 characters", "can't be blank"]
      })
    end

    describe "username" do
      describe "validations" do
        
        it "uniqueness" do
          create(:classic_credential, username: 'james')
          credential = build(:classic_credential, username: 'james')
          credential.valid?
          expect(credential.errors[:username]).to eq ["already exists"]
        end

        it "#username_used_by_another?" do
          i1 = create(:classic_credential)
          i2 = build(:classic_credential, username: '')
          is_used_by_another = i2.username_used_by_another?(i1.username)
          expect(is_used_by_another).to eq(true)
        end

        it "format" do
          credential = build(:classic_credential)

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

      describe "#make_up_new_username" do

        let(:model) { build(:classic_credential, username: '') }

        it "works when called" do
          a_username = model.make_up_new_username
          expect(a_username.length).to eq(32)
          expect(model.username).to eq('')
        end

        it "gets ignored due to PresenceValidator" do
          expect(model).not_to receive(:make_up_new_username)
          model.valid?
          expect(model.username).to eq('')
        end

        it "gets invoked when PresenceValidator is removed" do
          model._validators[:username].delete_if { |v| v.is_a? ActiveRecord::Validations::PresenceValidator }

          expect(model).to receive(:make_up_new_username).and_return("RAILS-ROCKS")
          model.valid?
          expect(model.username).to eq("RAILS-ROCKS")
        end
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
            expect(@credential.errors[:email]).to include "can't be blank"
          end

          it "format" do
            @credential.email = 'aaa'
            @credential.valid?
            expect(@credential.errors[:email]).to eq ["does not appear to be a valid e-mail address"]

            @credential.email = 'email@hello.com'
            @credential.valid?
            expect(@credential.errors[:email]).to be_empty
          end

          it "uniqueness" do
            email = 'email@hello.com'

            model1 = build(:classic_credential, email: email)
            model1.save

            expect(model1.errors.messages).to eq({})
            expect(model1.persisted?).to eq(true)

            model2 = build(:classic_credential, email: email)
            model2.valid?
            # expect(model2.errors[:email]).to eq ["has already been taken"]
            expect(model2.errors[:email]).to eq ["already exists"]
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
