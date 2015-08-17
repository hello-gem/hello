require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Authentication", "Switch Accounts", "Switch Account Button" do



    sstory "Has One Account" do
      before(:each) do
        Given "I have singed in with one account" do
          given_I_have_signed_in
          expect_to_see "dummy-accounts-1"
        end
      end

      sscenario "Success" do
        When "I attempt to sign out from one of my accounts" do
          click_link "Switch Accounts"
        end
        
        Then "I should not see a button to switch accounts" do
          expect(page).not_to have_link('Switch!')
        end
      end
    end



    sstory "Has Two Accounts" do
      before(:each) do
        Given "I have singed in with two accounts" do
          given_I_am_logged_in_with_two_accounts
        end
      end
      
      sscenario "Success" do
        When "I attempt to switch to another account" do
          click_link "Switch Accounts"
          click_link "Switch!"
        end
        
        Then "I should see a confirmation message" do
          expect_flash_notice "Switched Accounts Successfully!"
        end

        Then "I should be signed in as my first account now" do
          then_I_expect_to_be_signed_in_with_role('user')
        end
      end
    end



  end
end
