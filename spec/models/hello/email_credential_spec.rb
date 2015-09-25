require 'spec_helper'

module Hello
  describe EmailCredential do

    example "Validations" do
      subject.valid?
      expect(subject.errors.messages).to eq({
        :user=>["can't be blank"],
        :email=>["can't be blank", "does not appear to be a valid e-mail address"],
      })
    end



    context "Fields" do
      describe "#email" do
        context "Validations" do

          example "Presence" do
            subject.valid?
            expect(subject.errors[:email]).to include "can't be blank"
          end

          example "Format" do
            subject.email = 'aaa'
            subject.valid?
            expect(subject.errors[:email]).to eq ["does not appear to be a valid e-mail address"]

            subject.email = 'email@hello.com'
            subject.valid?
            expect(subject.errors[:email]).to be_empty
          end

          describe "Uniqueness" do
            def test_uniqueness(a, b)
              create(:email_credential, email: a)
              subject.email = b
              subject.valid?
              expect(subject.errors.added?(:email, :taken)).to eq(true)
            end
            
            example "With normal case" do
              test_uniqueness("james@hello.com", "james@hello.com")
            end

            example "Downcased" do
              test_uniqueness("JaMeS@HELLO.com", "james@hello.com")
            end
          end
        end

        describe "#email=" do
          example "nil" do
            subject.email=nil
            expect(subject.email).to eq("")
          end

          example "spaced" do
            subject.email=" jame s @hello.com   "
            expect(subject.email).to eq("james@hello.com")
          end
        end

      end

    end

  end
end
