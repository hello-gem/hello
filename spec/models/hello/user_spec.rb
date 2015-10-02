require 'spec_helper'

module Hello
  describe User do
    before(:each) do
      @user = User.new
    end

    describe "validations" do
      it "presence of name" do
        @user.valid?
        # city is only here because we need to test code customization, and this is how we are currently testing it
        expect(@user.errors.messages).to eq(
        {
          :name=>["can't be blank"],
          :locale=>["can't be blank", "is not included in the list"],
          :time_zone=>["can't be blank", "is not included in the list"],
          :city=>["can't be blank"],
          # :username=>["is invalid", "minimum of 4 characters", "can't be blank"]
        }
        )
      end
    end

    describe "passwords" do
      example "one is automatically created with factories" do
        expect {
          create(:user)
        }.to change { PasswordCredential.count }.from(0).to(1)
      end
    end

        
    describe "username" do

      describe "setter" do
        it "nil" do
          expect { User.new.username=nil }.not_to raise_error
        end

        it "spaced" do
          user = User.new
          user.username=" jame s "
          expect(user.username).to eq("james")
        end

      end

      describe "validations" do
        
        describe "uniqueness" do
          def test_uniqueness(a, b)
            create(:user, username: a)
            user = build(:user, username: b)
            user.valid?          
            # expect(user.errors.messages).to eq(1)
            expect(user.errors.added?(:username, :taken)).to eq(true)
          end

          it "normal case" do
            test_uniqueness("james", "james")
          end

          it "downcase" do
            test_uniqueness("JaMeS", "james")
          end

        end

        it "#username_used_by_another?" do
          i1 = create(:user)
          i2 = build(:user, username: '')
          is_used_by_another = i2.username_used_by_another?(i1.username)
          expect(is_used_by_another).to eq(true)
        end

        it "format" do
          user = build(:user)

          invalid_usernames = ["*****", "James!", "James@", "@James", "James?", "james#", "james$", "james%", "james&", "james*", "james("]
          invalid_usernames.each do |username|
            user.username = username
            user.valid?
            err = user.errors[:username]
            expect(err).to eq(["is invalid"]), "'#{err}' when username is '#{username}'"
          end
          
          valid_usernames = ["james", "James", "JAMES", "James88", "88James", "88-james", "james_88"]
          valid_usernames.each do |username|
            user.username = username
            user.valid?
            err = user.errors[:username]
            expect(err).to eq([]), "'#{err}' when username is '#{username}'"
          end

        end

      end

      describe "#make_up_new_username" do

        let(:model) { build(:user, username: '') }

        it "gets ignored due to PresenceValidator" do
          model._validators[:username] << ActiveRecord::Validations::PresenceValidator.new({attributes: [:username]})
          expect(model).not_to receive(:make_up_new_username)
          model.valid?
          expect(model.username).to eq('')
          model._validators[:username].delete_if { |v| v.is_a? ActiveRecord::Validations::PresenceValidator }
        end

        it "works when called" do
          a_username = model.make_up_new_username
          expect(a_username.length).to eq(32)
          expect(model.username).to eq('')
        end

        it "gets invoked when no PresenceValidator" do
          expect(model).to receive(:make_up_new_username).and_return("rails-rocks")
          model.valid?
          expect(model.username).to eq("rails-rocks")
        end

      end
      
    end

  end
end
