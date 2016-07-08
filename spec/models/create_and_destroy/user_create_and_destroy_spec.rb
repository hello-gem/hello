require 'spec_helper'

describe User do

  describe 'ClassMethods' do
    describe '#new' do
      it "is not valid" do
        expect(subject).to be_invalid
        expect(subject.errors.messages).to eq({
         :locale=>["can't be blank", "is not included in the list"],
         :time_zone=>["can't be blank", "is not included in the list"],
         :name=>["can't be blank"],
         :city=>["can't be blank"],
         :email_credentials=>["is too short (minimum is 1 character)"],
         :username => ["can't be blank"],
         :email => ["can't be blank"],
         :password => ["can't be blank"],
        })
      end
    end

    describe ".create" do
      subject do
        build(:user, :without_credentials)
      end

      describe "invalid examples" do
        describe "number of emails" do
          it "does not save with 0 emails and 0 passwords" do
            expect(subject.save).to eq(false)
            expect(User.count).to eq(0)
          end

          it "does not save with 0 email and 1 password" do
            subject.password_credentials.build(password: '1234')
            subject.save
            expect(subject.errors.messages).to eq({:email => ["can't be blank"], :email_credentials=>["is too short (minimum is 1 character)"]})
            expect(User.count).to eq(0)
            expect(Credential.count).to eq(0)
          end
        end

        describe "number of passwords" do
          it "does not save with 1 email and 0 passwords" do
            subject.email_credentials.build(email: 'foo@example.com')
            subject.save
            expect(subject.errors.messages).to eq(:password => ["can't be blank"])
            expect(User.count).to eq(0)
            expect(Credential.count).to eq(0)
          end

          it "does not save with 1 email and 2 passwords" do
            subject.email_credentials.build(email: 'foo@example.com')
            subject.password_credentials.build(password: '1234')
            subject.password_credentials.build(password: '5678')
            subject.save
            expect(subject.errors.messages).to eq(:password_credentials => ["is the wrong length (should be 1 character)"])
            expect(User.count).to eq(0)
            expect(Credential.count).to eq(0)
          end
        end
      end

      describe "valid examples" do
        it "save with 1 email and 1 passwords" do
          subject.email_credentials.build(email: 'foo@example.com')
          subject.password_credentials.build(password: '1234')
          subject.save
          expect(subject.errors.messages).to eq({})
          expect(User.count).to eq(1)
          expect(Credential.count).to eq(2)
        end

        it "save with 2 email and 1 passwords" do
          subject.email_credentials.build(email: 'foo@example.com')
          subject.email_credentials.build(email: 'bar@example.com')
          subject.password_credentials.build(password: '1234')
          subject.save
          expect(subject.errors.messages).to eq({})
          expect(User.count).to eq(1)
          expect(Credential.count).to eq(3)
        end
      end
    end

    describe ".destroy!" do
      describe "valid examples" do
        describe "with 1 email and 1 password" do
          subject do
            u = build(:user)
            u.save!
            u
          end

          it "works" do
            subject # touch
            expect(User.count).to eq(1)
            expect(Credential.count).to eq(2)
            subject.destroy!
            expect(User.count).to eq(0)
            expect(Credential.count).to eq(0)
          end
        end
        describe "with 2 emails and 1 password" do
          subject do
            u = build(:user)
            u.email_credentials.build(email: 'bar@example.com')
            u.save!
            u
          end

          it "works" do
            subject # touch
            expect(User.count).to eq(1)
            expect(Credential.count).to eq(3)
            subject.destroy!
            expect(User.count).to eq(0)
            expect(Credential.count).to eq(0)
          end
        end
      end
    end
  end

end
