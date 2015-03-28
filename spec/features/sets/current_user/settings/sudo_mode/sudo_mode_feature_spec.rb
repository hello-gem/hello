require 'spec_helper'

RSpec.describe "Top Feature Set: Current User", :type => :feature do
  context "Feature Set: Settings" do




    feature "Feature Set: Sudo Mode" do

      feature "Feature: Enable" do
        
        before do
          given_I_have_signed_in

          click_link "Settings"
          click_link "Access Tokens"

          expect(page).to have_content "Confirm Password to Continue"
          expect(current_path).to eq hello.access_tokens_path
          expect(AccessToken.last.sudo_expires_at).to be < Time.now
        end

        context "Scenarios: Failure" do
          scenario "Scenario: Blank" do
            When "I submit an empty form" do
              when_I_confirm_my_user_password('', false)
            end
          end
          scenario "Scenario: Wrong" do
            When "I submit an incorrect password" do
              when_I_confirm_my_user_password('wrong', false)
            end
          end

          after do
            Then "I expect to see an error message" do
              expect_flash_alert "Incorrect Password"
            end

            then_I_expect_not_to_be_on_sudo_mode

            # expect(page).to have_content "Confirm Password to Continue"
            # expect(current_path).to eq hello.sudo_mode_path
            # expect(AccessToken.last.sudo_expires_at).to be < Time.now
          end
        end

        scenario "Scenario: Success" do
          When "I submit the correct password" do
            when_I_confirm_my_user_password
          end

          Then "I expect to see a confirmation message" do
            expect_flash_notice "Now we know it's really you. We won't be asking your password again for 60 minutes"
          end

          then_I_expect_to_be_on_sudo_mode
          # expect(page).to have_content "Sudo Mode expires in"
          # expect(page).not_to have_content "Confirm Password to Continue"
          # expect(current_path).to eq hello.access_tokens_path
          # expect(AccessToken.last.sudo_expires_at).to be > 29.minutes.from_now
        end
      end

      feature "Feature: Disable" do
        scenario "Scenario: Success" do
          given_I_have_signed_in_with_sudo_mode

          When "I click 'expire'" do
            click_link "expire"
          end

          Then "I expect to see a confirmation message" do
            expect_flash_notice "We will now ask your password for sensitive access"
          end
          
          then_I_expect_not_to_be_on_sudo_mode
        end

        scenario "Scenario: Failure" do
          skip "provide scenario on how a Sudo Expiration can go wrong"
        end
      end

    end
  end
end
