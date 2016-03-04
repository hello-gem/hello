require 'spec_helper'

module Hello
  describe ClassicSignInEntity do
    describe '.authenticate(string, string)' do
      describe 'original state' do
        it('no errors')           { expect(subject.errors.messages).to eq({}) }
        it('good login')          { expect(subject.bad_login?).to eq(false) }
        it('good password')       { expect(subject.bad_password?).to eq(false) }
        it('user not persisted')  { expect(subject.user).not_to be_persisted }
      end

      describe 'blank, blank' do
        before do
          subject.authenticate('', '')
        end

        it('has errors')          { expect(subject.errors.messages).to eq(login: ["can't be blank"], password: ["can't be blank"]) }
        it('not bad login')       { expect(subject.bad_login?).to eq(false) }
        it('not bad password')    { expect(subject.bad_password?).to eq(false) }
        it('user not persisted')  { expect(subject.user).not_to be_persisted }
      end

      describe 'not found, blank' do
        before do
          subject.authenticate('notfound', '')
        end

        it('has errors')          { expect(subject.errors.messages).to eq(password: ["can't be blank"]) }
        it('not bad login')       { expect(subject.bad_login?).to eq(false) }
        it('not bad password')    { expect(subject.bad_password?).to eq(false) }
        it('user not persisted')  { expect(subject.user).not_to be_persisted }
      end

      describe 'found, blank' do
        before do
          create(:user_user)
          subject.authenticate('user', '')
        end

        it('no errors')          { expect(subject.errors.messages).to eq(password: ["can't be blank"]) }
        it('good login')         { expect(subject.bad_login?).to eq(false) }
        it('not bad password')   { expect(subject.bad_password?).to eq(false) }
        it('user not persisted') { expect(subject.user).not_to be_persisted }
      end

      describe 'found, incorrect' do
        before do
          create(:user_user)
          subject.authenticate('user', 'wrong')
        end

        it('has errors')         { expect(subject.errors.messages).to eq(password: ['is incorrect']) }
        it('good login')         { expect(subject.bad_login?).to eq(false) }
        it('has a bad password') { expect(subject.bad_password?).to eq(true) }
        it('user persisted')     { expect(subject.user).to be_persisted }
      end

      describe 'found, correct' do
        before do
          create(:user_user)
          subject.authenticate('user', '1234')
        end

        it('no errors')           { expect(subject.errors.messages).to eq({}) }
        it('good login')          { expect(subject.bad_login?).to eq(false) }
        it('good password')       { expect(subject.bad_password?).to eq(false) }
        it('user persisted')      { expect(subject.user).to be_persisted }
      end
    end
  end
end
