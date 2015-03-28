require 'spec_helper'

RSpec.describe "Top Feature Set: Current User", :type => :feature do
  context "Feature Set: Settings" do
    feature "Feature Set: Access Tokens" do





      feature "Feature: Unlink" do
        
        scenario "Scenario: Success" do
          given_I_have_signed_in_with_sudo_mode

          Given "I have a second device signed in" do
            create(:access_token, user: User.last)
          end

          Given "I go to Settings > Access Tokens" do
            click_link "Settings"
            click_link "Access Tokens (2)"
          end

          When "I click 'Unlink'" do
            click_button "Unlink"
          end

          Then "I should see a confirmation message" do
            expect_flash_notice("Device has been unlinked from your account")
          end

          Then "I should only see one access token" do
            then_I_should_see("Access Tokens (1)")
          end
        end

        scenario "Scenario: Failure" do
          skip "DestroyAccessTokenEntity#alert_message"
        end

      end

      feature "Feature: Generate" do

        scenario "Scenario: Success" do
          skip "TODO"
        end

        scenario "Scenario: Failure" do
          skip "TODO"
        end
      end


      feature "Feature: Unlinked" do
        scenario "Scenario: Success (Single)" do
          given_I_have_signed_in
          
          then_I_expect_to_be_signed_in

          When "My Access Token gets destroyed by somebody else" do
            AccessToken.destroy_all
            visit hello.root_path
          end

          then_I_expect_to_be_signed_out
        end
      end

      
    end
  end
end
