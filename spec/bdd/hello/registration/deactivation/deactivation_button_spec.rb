require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Registration", "Deactivation", "Button" do



    def _when_I_attempt_to_deactivate_but_before(&block)
      given_I_have_signed_in_with_sudo_mode
      yield if block_given?
      When "I attempt to deactivate" do
        visit "/hello/deactivation"
        click_button "Deactivate my Account"
      end
    end



    sstory "Valid Destroy" do

      sscenario "Valid" do
        _when_I_attempt_to_deactivate_but_before

        Then "I should see a confirmation message" do
          expect_flash_notice "You have deactivated your account successfully"
        end

        Then "and I should be signed out" do
          then_I_expect_to_be_signed_out
        end

        Then "and my data should be removed from the database" do
          expect(User.count).to        eq(0)
          expect(Credential.count).to  eq(0)
          expect(Access.count).to eq(0)
        end
      end

    end



    sstory "Invalid Destroy" do

      sscenario "Scenario 1: User has dependent children" do
        _invalid_scenarios_but_before do
          But "User has dependent children" do
            User.last.addresses.create! text: "foo"
          end
        end
      end



      sscenario "Scenario 2: User has dependent grandchildren" do
        _invalid_scenarios_but_before do
          But "User has dependent grandchildren" do
            Credential.last.some_credential_data.create! text: "foo"
          end
        end
      end



      def _invalid_scenarios_but_before(&block)
        _when_I_attempt_to_deactivate_but_before(&block)

        then_I_expect_to_be_signed_in

        Then "and see an error message" do
          expect_flash_alert "Terminating your account would cause other users to experience errors while using our website. Please contact any of our staff members and ask to have your account removed manually."
        end
        
        Then "and my data should remain in the database" do
          expect(User.count).to        eq(1)
          expect(Credential.count).to  eq(1)
          expect(Access.count).to eq(1)
        end
      end

    end



  end
end
