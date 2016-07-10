require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new
  end

  describe 'setter' do
    it 'nil' do
      expect { User.new.username = nil }.not_to raise_error
    end

    it 'spaced' do
      user = User.new
      user.username = ' jame s '
      expect(user.username).to eq('james')
    end
  end

  describe 'validations' do
    it 'creating' do
      @user.valid?
      expect(@user.errors.messages).to eq(
        :name=>["can't be blank"],
        :locale=>["can't be blank", 'is not included in the list'],
        :time_zone=>["can't be blank", 'is not included in the list'],
        :username=>["can't be blank"],
        :email=>["can't be blank"],
        :password=>["can't be blank"],
        :email_credentials=>["is too short (minimum is 1 character)"],
      )
    end

    it 'updating' do
      @user = create(:user)
      attrs = attributes_for(:user)
      attrs.each { |k, _v| attrs[k] = nil }
      expect(@user.update(attrs)).to eq(false)
      expect(@user.errors.messages).to eq(
        :name=>["can't be blank"],
        :locale=>["can't be blank", 'is not included in the list'],
        :time_zone=>["can't be blank", 'is not included in the list'],
        :username=>["can't be blank"],
        :role=>["can't be blank"],
      )
    end
  end

  describe 'passwords' do
    example 'one is automatically created with factories' do
      expect do
        create(:user)
      end.to change { PasswordCredential.count }.from(0).to(1)
    end
  end

  describe 'username' do
    describe 'validations' do
      describe 'uniqueness' do
        def expects_uniqueness_to_be_applied(a, b)
          user1 = build(:user)
          user1.username = a
          user1.save!

          user2 = build(:user)
          user2.username = b
          user2.valid?
          expect(user2.errors.messages).to eq({:username=>["has already been taken"]})
        end

        def expects_uniqueness_to_be_ignored(a, b)
          user1 = build(:user)
          user1.username = a
          user1.save!

          user2 = build(:user)
          user2.username = b
          user2.save!
          expect(user2.errors.messages).to eq({})
        end

        describe "config" do
          subject { build(:user, username: '', email: 'foo@bar.com') }
          after do
            reload_initializer!
          end

          describe 'config.username_presence = true' do
            before do
              Hello.configure { |config| config.username_presence = true }
            end

            it 'requires a username' do
              expect(subject).to be_invalid
              expect(subject.errors.messages).to eq({:username=>["can't be blank"]})
            end

            it 'expects uniqueness to be applied for normal-cased usernames' do
              expects_uniqueness_to_be_applied('james', 'james')
            end

            it 'expects uniqueness to be applied for down-cased usernames' do
              expects_uniqueness_to_be_applied('JaMeS', 'james')
            end
          end

          describe 'config.username_presence = false' do
            before do
              Hello.configure { |config| config.username_presence = false }
            end

            it 'does not require a username' do
              expect(subject).to be_valid
              expect(subject.errors.messages).to eq({})
            end

            it 'expects uniqueness to be applied for normal-cased usernames' do
              expects_uniqueness_to_be_applied('james', 'james')
            end

            it 'expects uniqueness to be applied for down-cased usernames' do
              expects_uniqueness_to_be_applied('JaMeS', 'james')
            end

            it 'expects uniqueness to be ignored for blank usernames' do
              expects_uniqueness_to_be_ignored('', '')
            end
          end
        end
      end

      it 'format' do
        user = build(:user)

        invalid_usernames = ['*****', 'James!', 'James@', '@James', 'James?', 'james#', 'james$', 'james%', 'james&', 'james*', 'james(']
        invalid_usernames.each do |username|
          user.username = username
          user.valid?
          err = user.errors[:username]
          expect(err).to eq(['is invalid']), "'#{err}' when username is '#{username}'"
        end

        valid_usernames = ['james', 'James', 'JAMES', 'James88', '88James', '88-james', 'james_88']
        valid_usernames.each do |username|
          user.username = username
          user.valid?
          err = user.errors[:username]
          expect(err).to eq([]), "'#{err}' when username is '#{username}'"
        end
      end
    end
  end
end
