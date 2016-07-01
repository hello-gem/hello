require 'spec_helper'

describe EmailCredential do
  example 'Validations' do
    subject.valid?
    expect(subject.errors.messages).to eq(email: ["can't be blank"])
  end

  context 'Fields' do
    describe '#email' do
      context 'Validations' do
        after do
          reload_initializer!
        end

        example 'Presence' do
          subject.valid?
          expect(subject.errors[:email]).to include "can't be blank"
        end

        describe 'Format' do
          describe 'config.email_regex = DEFAULT' do
            it 'invalid' do
              subject.email = 'aaaa'
              subject.valid?
              expect(subject.errors[:email]).to eq ['is invalid']
            end

            it 'valid' do
              subject.email = 'email@hello.com'
              subject.valid?
              expect(subject.errors[:email]).to be_empty
            end
          end # describe config

          describe 'config.email_regex = LETTERS' do
            before do
              Hello.configure { |config| config.email_regex = /\A[a-z]+\z/i }
            end

            it 'valid' do
              subject.email = 'aaaa'
              subject.valid?
              expect(subject.errors[:email]).to be_empty
            end

            it 'invalid' do
              subject.email = 'aaaa1234'
              subject.valid?
              expect(subject.errors[:email]).to eq ['is invalid']
            end
          end # describe config

          describe 'config.email_regex = LETTERS_AND_NUMBERS' do
            before do
              Hello.configure { |config| config.email_regex = /\A[a-z0-9]+\z/i }
            end

            it 'valid 1' do
              subject.email = 'aaaa'
              subject.valid?
              expect(subject.errors[:email]).to eq([])
            end

            it 'valid 2' do
              subject.email = 'aaaa1234'
              subject.valid?
              expect(subject.errors[:email]).to eq([])
            end
          end # describe config
        end # describe Format

        describe 'Length' do
          describe 'config.email_length = DEFAULT (4..250)' do
            it '3 is invalid' do
              subject.email = '123'
              subject.valid?
              expect(subject.errors[:email]).to include 'is too short (minimum is 4 characters)'
            end

            it '4 is valid' do
              subject.email = '1234'
              subject.valid?
              expect(subject.errors[:email]).to eq(['is invalid']) # but is valid in this context
            end

            it '250 is valid' do
              subject.email = '1' * 250
              subject.valid?
              expect(subject.errors[:email]).to eq(['is invalid']) # but is valid in this context
            end

            it '251 is invalid' do
              subject.email = '1' * 251
              subject.valid?
              expect(subject.errors[:email]).to include 'is too long (maximum is 250 characters)'
            end
          end # describe config

          describe 'config.email_length = 2..10' do
            before do
              Hello.configure { |config| config.email_length = 2..10 }
            end

            it '1 is invalid' do
              subject.email = '1'
              subject.valid?
              expect(subject.errors[:email]).to include 'is too short (minimum is 2 characters)'
            end

            it '2 is valid' do
              subject.email = '22'
              subject.valid?
              expect(subject.errors[:email]).to eq(['is invalid']) # but is valid in this context
            end

            it '10 is valid' do
              subject.email = '1234567890'
              subject.valid?
              expect(subject.errors[:email]).to eq(['is invalid']) # but is valid in this context
            end

            it '11 is invalid' do
              subject.email = '12345678901'
              subject.valid?
              expect(subject.errors[:email]).to include 'is too long (maximum is 10 characters)'
            end
          end # describe config
        end # describe Length

        describe 'Uniqueness' do
          def test_uniqueness(a, b)
            create(:email_credential, email: a)
            subject.email = b
            subject.valid?
            expect(subject.errors.added?(:email, :taken)).to eq(true)
          end

          example 'With normal case' do
            test_uniqueness('james@hello.com', 'james@hello.com')
          end

          example 'Downcased' do
            test_uniqueness('JaMeS@HELLO.com', 'james@hello.com')
          end
        end
      end

      describe '#email=' do
        example 'nil' do
          subject.email = nil
          expect(subject.email).to eq('')
        end

        example 'spaced' do
          subject.email = ' jame s @hello.com   '
          expect(subject.email).to eq('james@hello.com')
        end
      end
    end
  end
end
