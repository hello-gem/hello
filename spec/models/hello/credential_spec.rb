require 'spec_helper'

module Hello
  describe Credential do

    it "validations" do
      model = Credential.new
      model.valid?
      expect(model.errors.messages).to eq({
        :user=>["can't be blank"],
        :strategy=>["can't be blank", "is not included in the list"],
      })
    end




    describe "strategies" do
      describe "commmon aspects" do

        describe "validations" do
          it "presence" do
            credential = Credential.new
            credential.valid?
            expect(credential.errors[:strategy]).to include "can't be blank"
            expect(credential.errors[:user]).to     include "can't be blank"
          end

          it "inclusion" do
            credential = Credential.new
            credential.strategy = 'madeup'
            credential.valid?
            expect(credential.errors[:strategy]).to eq ["is not included in the list"]
          end
        end

      end





      describe "classic strategy" do

        before(:each) do
          @credential = Credential.classic.new
        end

        describe "email" do
          describe "validations" do

            it "presence" do
              @credential.valid?
              expect(@credential.errors[:email]).to include "can't be blank"
            end

            it "format" do
              @credential.email = 'aaa'
              @credential.valid?
              expect(@credential.errors[:email]).to eq ["does not appear to be a valid e-mail address"]

              @credential.email = 'email@hello.com'
              @credential.valid?
              expect(@credential.errors[:email]).to be_empty
            end

            describe "uniqueness" do
              def test_uniqueness(a, b)
                create(:classic_credential, email: a)
                credential = build(:classic_credential, email: b)
                credential.valid?          
                # expect(credential.errors.messages).to eq(1)
                expect(credential.errors.added?(:email, :taken)).to eq(true)
              end
              
              it "normal case" do
                test_uniqueness("james@hello.com", "james@hello.com")
              end

              it "downcase" do
                test_uniqueness("JaMeS@HELLO.com", "james@hello.com")
              end
            end
          end

          describe "setter" do
            it "nil" do
              expect { Credential.new.email=nil }.not_to raise_error
            end

            it "spaced" do
              credential = Credential.new
              credential.email=" jame s @hello.com   "
              expect(credential.email).to eq("james@hello.com")
            end
          end

        end

      end
      
    end






  end
end
