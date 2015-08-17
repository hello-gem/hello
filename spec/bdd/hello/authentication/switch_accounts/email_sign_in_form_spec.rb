require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Authentication", "Switch Accounts", "Email Sign In Form" do



    sstory "Has One Account" do
      before(:each) do
        Given "I have singed in with one account" do
          given_I_have_signed_in
          expect_to_see "dummy-accounts-1"
        end
      end
      
      sscenario "Success" do
        When "I attempt to sign in with a second account" do
          given_I_have_a_webmaster_password_credential
          when_sign_in_with_webmaster_data
          then_I_expect_to_be_signed_in_with_role('webmaster')
        end
        
        Then "I should see I have 2 accounts" do
          expect_to_see "dummy-accounts-2"
          expect_to_see "dummy-account-webmaster"
          expect_to_see "dummy-account-foobar"
        end
      end



      sscenario "Invalid Credentials" do
        When "I attempt to sign in with invalid credentials" do
          when_sign_in('', '')
          then_I_expect_to_be_signed_in_with_role('user')
        end
        
        Then "I should see I have 1 account" do
          expect_to_see "dummy-accounts-1"
          expect_to_see "dummy-account-foobar"
        end
      end
    end



  end
end
