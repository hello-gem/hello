require 'spec_helper'

RSpec.describe "Top Feature Set: Current User", :type => :feature do
  context "Feature Set: Settings" do




    feature "Feature: Cancel Account" do

      def _given_I_visit
        Given "I go to Settings > Cancel Account" do
          click_link "Settings"
          click_link "Cancel Account"
        end
      end

      def _when_I_click
        When "I click 'Deactivate My Account'" do
          click_button "Deactivate my Account"
        end
      end

      scenario "Valid Scenario" do
        given_I_have_signed_in_with_sudo_mode

        _given_I_visit

        _when_I_click

        Then "I should see a confirmation message" do
          expect_flash_notice "You have deactivated your account successfully"
        end

        then_I_expect_to_be_signed_out

        Then "I expect my data removed from the Database" do
          expect(User.count).to        eq(0)
          expect(Credential.count).to  eq(0)
          expect(AccessToken.count).to eq(0)
        end
      end





      context "Invalid Scenarios" do

        context "Validation: has_many restrict_with_error" do





          scenario "Scenario 1: User has dependent children" do
            given_I_have_signed_in_with_sudo_mode

            Given "User has dependent children" do
              User.last.addresses.create! text: "foo"
            end

            _invalid_scenarios
          end

          # KNOWNBUG: this scenario only fails in Rails 4.0
          scenario "Scenario 2: User has dependent grandchildren" do
            given_I_have_signed_in_with_sudo_mode

            Given "User has dependent grandchildren" do
              Credential.last.some_credential_data.create! text: "foo"
            end

            _invalid_scenarios
          end





          def _invalid_scenarios
            _given_I_visit

            _when_I_click

            then_I_expect_to_be_signed_in

            Then "I should see an error message" do
              expect_flash_alert "Terminating your account would cause other users to experience errors while using our website. Please contact any of our staff members and ask to have your account removed manually."
            end
            
            Then "I expect my data to remain in the Database" do
              expect(User.count).to        eq(1)
              expect(Credential.count).to  eq(1)
              expect(AccessToken.count).to eq(1)
            end
          end
        end

      end







    end
  end
end