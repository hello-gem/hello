require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new
  end

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
    it "validations" do
      @user.valid?
      # city is only here because we need to test code customization, and this is how we are currently testing it
      expect(@user.errors.messages).to eq(
      {
        :name=>["can't be blank"],
        :locale=>["can't be blank", "is not included in the list"],
        :time_zone=>["can't be blank", "is not included in the list"],
        :city=>["can't be blank"],
        :username=>["can't be blank", "is invalid", "is too short (minimum is 4 characters)"]
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

    describe "private ._make_up_new_username" do

      let(:model) { build(:user, username: '') }

      it "works when called" do
        a_username = model.send(:_make_up_new_username)
        expect(a_username.length).to eq(32)
        expect(model.username).to eq('')
      end

    end

  end

end
