require 'spec_helper'

describe PasswordCredential do

  describe 'ClassMethods' do
    describe '#new' do
      it "is not valid" do
        expect(subject).to be_invalid
        expect(subject.errors.messages).to eq({:password => ["can't be blank"]})
      end
    end

    describe ".create" do
      subject { PasswordCredential.new(password: '1234') }

      describe "valid examples" do
        describe "does  save without a user" do
          it "does  save without a user" do
            expect(subject.user).to eq(nil)
            expect(subject.save).to eq(true)
            expect(Credential.count).to eq(1)
          end

          it "does  save with an invalid user" do
            subject.user = User.new
            expect(subject.save).to eq(true)
            expect(subject.errors.messages).to eq({})
            expect(Credential.count).to eq(1)
          end
        end

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
      end
    end
  end
end
