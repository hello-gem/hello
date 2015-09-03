require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Authentication", "Sign Out", "Unlink" do



    sstory "Valid" do
      sscenario "Success" do
        given_I_have_signed_in_with_sudo_mode

        Given "I have a second device signed in" do
          create(:valid_access_token, user: User.last)
          expect(AccessToken.count).to eq(2)
        end

        When "I attempt to unlink it" do
          click_link "Settings"
          click_link "Access Tokens (2)"
          click_button "Unlink"
        end

        Then "I should see a confirmation message" do
          expect_flash_notice("Device has been unlinked from your account")
        end

        Then "and it should be removed from the database" do
          expect(AccessToken.count).to eq(1)
        end
      end
    end



  end
end
