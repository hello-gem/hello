require 'spec_helper'

describe EmailCredential do

  describe 'ClassMethods' do
    describe '#new' do
      it "is not valid" do
        expect(subject).to be_invalid
        expect(subject.errors.messages).to eq({:email => ["can't be blank"]})
      end
    end

    describe ".create" do
      subject { EmailCredential.new(email: 'foo@example.com') }

      describe "invalid examples" do
        describe "does not save without a user" do
          it "does not save without a user" do
            expect(subject.user).to eq(nil)
            expect(subject.save).to eq(nil)
            expect(Credential.count).to eq(0)
          end

          it "does not save with an invalid user" do
            subject.user = User.new
            expect(subject.save).to eq(false)
            expect(subject.errors.messages).to eq({:user=>["is invalid"]})
            expect(Credential.count).to eq(0)
          end
        end

      end

      describe "valid examples" do
        it "saves with a valid user" do
          user = create(:user)
          expect(Credential.count).to eq(2)
          subject.user = user
          expect(subject.save).to eq(true)
          expect(Credential.count).to eq(3)
        end

      end
    end

    describe ".destroy!" do
      describe "valid examples" do
        describe "with 1 email and 1 password" do
          subject { create(:user) }

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
            u = create(:user)
            u.email_credentials.create!(email: 'bar@example.com')
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
