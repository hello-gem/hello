require 'spec_helper'

module Hello
  describe ClassicSignUpEntity do
    describe '.register(email:string, username:string, password:string)' do
      let(:valid_attrs) { { city: 'Brasilia', name: 'James Pinto', email: 'foo@bar.com', username: 'foobar', password: 'foobar' } }

      describe 'original state' do
        it('no errors') { expect(subject.errors.messages).to eq({}) }
      end # describe

      describe 'all blank' do
        before do
          subject.register({})
        end
        it('a lot of errors') { expect(subject.errors.messages).to eq(email: ["can't be blank"], name: ["can't be blank"], city: ["can't be blank"], password: ["can't be blank"], username: ["can't be blank"]) }
      end # describe

      describe 'by field' do
        def perform
          if value
            valid_attrs[field] = value
          else
            valid_attrs.delete(field)
          end
          subject.register(valid_attrs)
          @errors = subject.errors[field]
        end

        after do
          reload_initializer!
        end

        # helpers

        def self.it_registers
          it('registers') { expect(::User.count).to eq(1) }
        end

        def self.it_does_not_register
          it('does not register') { expect(::User.count).to eq(0) }
        end

        def self.it_is_invalid
          it('has errors') { expect(@errors).to eq(['is invalid']) }
        end

        def self.it_cant_be_blank
          it('has errors') { expect(@errors).to eq(["can't be blank"]) }
        end

        def self.it_does_not_have_errors
          it('does not have errors') { expect(@errors).to eq([]) }
        end

        #

        describe 'email' do
          let(:field) { :email }

          describe 'config.email_presence = true' do
            before do
              Hello.configure { |config| config.email_presence = true }
              perform
            end

            describe 'ignored' do
              let(:value) { nil }
              it_cant_be_blank
              it_does_not_register
            end # describe

            describe 'blank' do
              let(:value) { '' }
              it_cant_be_blank
              it_does_not_register
            end # describe

            describe 'invalid' do
              let(:value) { 'foobar' }
              it_is_invalid
              it_does_not_register
            end # describe

            describe 'valid' do
              let(:value) { 'foo@bar.com' }
              it_does_not_have_errors
              it_registers
            end # describe
          end # describe config

          describe 'config.email_presence = false' do
            before do
              Hello.configure { |config| config.email_presence = false }
              perform
            end

            describe 'ignored' do
              let(:value) { nil }
              it_does_not_have_errors
              it_registers
            end # describe

            describe 'blank' do
              let(:value) { '' }
              it_does_not_have_errors
              it_registers
            end # describe

            describe 'invalid' do
              let(:value) { 'foobar' }
              it_is_invalid
              it_does_not_register
            end # describe

            describe 'valid' do
              let(:value) { 'foo@bar.com' }
              it_does_not_have_errors
              it_registers
            end # describe
          end # describe config
        end # describe email

        describe 'username' do
          let(:field) { :username }

          describe 'config.username_presence = true' do
            before do
              Hello.configure { |config| config.username_presence = true }
              perform
            end

            describe 'ignored' do
              let(:value) { nil }
              it_cant_be_blank
              it_does_not_register
            end # describe

            describe 'blank' do
              let(:value) { '' }
              it_cant_be_blank
              it_does_not_register
            end # describe

            describe 'invalid' do
              let(:value) { 'foobar!' }
              it_is_invalid
              it_does_not_register
            end # describe

            describe 'valid' do
              let(:value) { 'foobar' }
              it_does_not_have_errors
              it_registers
            end # describe
          end # describe config

          describe 'config.username_presence = false' do
            before do
              Hello.configure { |config| config.username_presence = false }
              perform
            end

            describe 'ignored' do
              let(:value) { nil }
              it_does_not_have_errors
              it_registers
            end # describe

            describe 'blank' do
              let(:value) { '' }
              it_does_not_have_errors
              it_registers
            end # describe

            describe 'invalid' do
              let(:value) { 'foobar!' }
              it_is_invalid
              it_does_not_register
            end # describe

            describe 'valid' do
              let(:value) { 'foobar' }
              it_does_not_have_errors
              it_registers
            end # describe
          end # describe config
        end # describe username

        describe 'password' do
          let(:field) { :password }

          describe 'config.password_presence = true' do
            before do
              Hello.configure { |config| config.password_presence = true }
              perform
            end

            describe 'ignored' do
              let(:value) { nil }
              it_cant_be_blank
              it_does_not_register
            end # describe

            describe 'blank' do
              let(:value) { '' }
              it_cant_be_blank
              it_does_not_register
            end # describe

            describe 'invalid' do
              let(:value) { 'foo bar' }
              it_is_invalid
              it_does_not_register
            end # describe

            describe 'valid' do
              let(:value) { 'foobar' }
              it_does_not_have_errors
              it_registers
            end # describe
          end # describe config

          describe 'config.password_presence = false' do
            before do
              Hello.configure { |config| config.password_presence = false }
              perform
            end

            describe 'ignored' do
              let(:value) { nil }
              it_does_not_have_errors
              it_registers
            end # describe

            describe 'blank' do
              let(:value) { '' }
              it_does_not_have_errors
              it_registers
            end # describe

            describe 'invalid' do
              let(:value) { 'foo bar' }
              it_is_invalid
              it_does_not_register
            end # describe

            describe 'valid' do
              let(:value) { 'foobar' }
              it_does_not_have_errors
              it_registers
            end # describe
          end # describe config
        end # describe password
      end # describe by field
    end # describe .register
  end # describe ClassicSignUpEntity
end # module Hello
