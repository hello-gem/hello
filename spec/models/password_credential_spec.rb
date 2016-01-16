require 'spec_helper'

describe PasswordCredential do
  describe 'validations' do
    it 'presence of name' do
      subject.valid?
      expect(subject.errors.messages).to eq(user: ["can't be blank"],
                                            password: ["can't be blank"])
    end
  end

  describe 'password' do
    describe 'validations' do
      it 'presence' do
        subject.valid?
        expect(subject.errors[:password]).to eq ["can't be blank"]
      end

      it 'length' do
        subject.password = '1' * 1
        subject.valid?
        expect(subject.errors[:password]).to eq ['is too short (minimum is 4 characters)']

        subject.password = '1' * 4
        subject.valid?
        expect(subject.errors[:password]).to be_empty

        subject.password = '1' * 251
        subject.valid?
        expect(subject.errors[:password]).to eq ['is too long (maximum is 250 characters)']
      end

      it 'spaced' do
        subject.password = '   123   4   '
        expect(subject.password_is?('1234')).to eq(false)
      end

      it 'cased' do
        subject.password = 'Abcd'
        expect(subject.password_is?('Abcd')).to eq(true)
        expect(subject.password_is?('abcd')).to eq(false)
      end

      describe 'format' do
        describe 'acceptable' do
          it('can have only letters') { @string = 'abcdef' }

          it('can have only numbers') { @string = '123456' }

          it('can start with letter') { @string = 'a12345' }

          it('can start with number') { @string = '1abcde' }

          after do
            subject.password = @string
            subject.valid?
            expect(subject.errors[:password]).to eq([])
          end
        end

        describe 'not acceptable' do
          it('cannot have spaces')  { @string = 'abc 123' }

          it('cannot have symbols') { @string = 'abc!123' }

          after do
            subject.password = @string
            subject.valid?
            expect(subject.errors[:password]).to eq(['is invalid'])
          end
        end
      end
    end
  end
end
