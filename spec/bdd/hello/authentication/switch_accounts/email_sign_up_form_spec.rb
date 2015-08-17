require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Authentication", "Switch Accounts", "Email Sign Up Form" do



    sstory "Has One Account" do
      before(:each) do
        Given "I have singed in with one account" do
          given_I_have_signed_in
          expect_to_see "dummy-accounts-1"
        end
      end

      

      sscenario "Success" do
        When "I attempt to sign up with a second account" do
          visit hello.sign_up_path
          within("form#new_sign_up") do
            fill_in 'sign_up_name',     with: 'James Pinto'
            fill_in 'sign_up_email',    with: 'novice@bar.com'
            fill_in 'sign_up_username', with: 'novice'
            fill_in 'sign_up_password', with: 'novice'
            fill_in 'sign_up_city',     with: 'OMG! I can customize Hello!'
            click_button 'Sign Up'
          end
          then_I_expect_to_be_signed_in_with_role('novice')
          expect_flash_notice "You have signed up successfully"
        end
        
        Then "I should see I have 2 accounts" do
          expect_to_see "dummy-accounts-2"
          expect_to_see "dummy-account-novice"
          expect_to_see "dummy-account-foobar"
        end
      end



      sscenario "Invalid Credentials" do
        When "I attempt to sign up with invalid credentials" do
          visit hello.sign_up_path
          click_button 'Sign Up'
          expect_error_message "6 errors were found while trying to sign up"
          expect(current_path).to eq hello.sign_up_path
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
