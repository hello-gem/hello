require 'spec_helper'

module Hello
  describe PasswordCredential do

    describe "validations" do
      it "presence of name" do
        subject.valid?
        expect(subject.errors.messages).to eq({
          :user=>["can't be blank"],
          :password=>["can't be blank"],
        })
      end
    end

    describe "password" do
      describe "validations" do

        it "presence" do
          subject.valid?
          expect(subject.errors[:password]).to include "can't be blank"
        end

        it "length" do
          subject.password = '1' * 1
          subject.valid?
          expect(subject.errors[:password]).to eq ["minimum of 4 characters"]

          subject.password = '1' * 4
          subject.valid?
          expect(subject.errors[:password]).to be_empty

          subject.password = '1' * 201
          subject.valid?
          expect(subject.errors[:password]).to eq ["maximum of 200 characters"]
        end

        it "spaced" do
          subject.password = "   123   4   "
          expect(subject.password_is?('1234')).to eq(true)
        end

        it "cased" do
          subject.password = "Abcd"
          expect(subject.password_is?('Abcd')).to eq(true)
          expect(subject.password_is?('abcd')).to eq(false)
        end
        
      end
    end


  end
end
