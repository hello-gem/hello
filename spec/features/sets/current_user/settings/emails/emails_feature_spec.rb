require 'spec_helper'

RSpec.describe "Top Feature Set: Current User", :type => :feature do
  context "Feature Set: Settings" do
    context "Feature Set: Emails" do

      before do
        given_I_have_signed_in_with_sudo_mode
        Given "I go to Settings > Emails" do
          click_link "Settings"
          click_link "Emails"
        end
      end

      feature "Feature: Adding an email" do

        context "Invalid Scenarios" do

          scenario "Can't be blank" do
            When "I submit an empty format" do
              click_button 'Add'
            end

            Then "I should see an error message" do
              expect_to_see "can't be blank"
            end
          end

          scenario "Malformed email" do
            When "I submit an invalid email" do
              fill_in 'credential_email', with: 'a@a'
              click_button 'Add'
            end

            Then "I should see an error message" do
              expect_to_see "does not appear to be a valid e-mail address"
            end
          end

          scenario "Already taken" do
            When "I submit my current email" do
              # new_email = create(:classic_credential).email
              new_email = Credential.last.email
              fill_in 'credential_email', with: new_email
              click_button 'Add'
            end

            Then "I should see an error message" do
              expect_to_see "has already been taken"
            end
          end

        end

        scenario "Valid Scenario" do
          When "I submit a valid email" do
            @new_email = 'thejamespinto@provider.com'
            fill_in 'credential_email', with: @new_email
            click_button 'Add'
          end

          Then "I should see a confirmation message" do
            expect_flash_notice "Your email was successfully added."
          end

          Then "It's in the database" do
            expect(current_user.credentials.last.email).to eq @new_email
          end
        end
      
      end

      feature "Feature: Sending Confirmation Email" do

        scenario "Valid Scenario" do
        
          Given "I should receive an email" do
            expect_any_instance_of(Hello::SendConfirmationEmailEntity).to receive(:deliver).and_call_original
          end

          When "I click the confirm button" do
            click_button "Confirm", match: :first
          end

          Then "I should see a confirmation message" do
            expect_to_see "We have sent a confirmation email to"
            expect_to_see "less than a minute ago"
          end

          Then "I should still see the Confirm button" do
            expect(page).to have_button("Confirm")
          end

        end

      end

      feature "Feature: Removing an email" do

        scenario "Valid Scenario" do
          Given "I have 2 emails" do
            create(:classic_credential, user: current_user)
            click_link "Emails"
          end

          When "I click remove" do
            click_button "Remove", match: :first
          end

          Then "I should see a confirmation message" do
            expect_to_see "Your email was successfully removed."
          end
        end

        scenario "Invalid Scenario" do
          Given "I have 1 email" do
          end

          When "I click remove" do
            click_button "Remove", match: :first
          end

          Then "I should see an error message" do
            expect_to_see "must have at least one credential"
          end
        end

      end

    end
  end
end