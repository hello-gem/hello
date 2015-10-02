require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Account Management", "Manage Password", "Password Page" do



    def self._before__given_I_am_on_the_password_page
      before do
        Given "I am on the Password Management Page" do
          given_I_have_signed_in_with_sudo_mode
          click_link "Settings"
          click_link "Password"
          expect(current_path).to eq hello.password_path
        end
      end
    end

    

    sstory "Update Password" do
      _before__given_I_am_on_the_password_page



      sscenario "Valid" do
        When "I submit a new valid password" do
          fill_in 'password_credential_password', with: (@new_password = 'new_password')
          click_button 'Update'
        end

        Then "I should see a confirmation message" do
          expect_flash_notice "You have updated your profile successfully"
        end

        then_I_expect_to_be_signed_in

        Then "and I should be able to sign in with the new password" do
          click_link "Sign Out"
          when_sign_in_with_standard_data(password: @new_password)
          expect_flash_notice "You have signed in successfully"
        end
      end



      sscenario "Invalid" do
        When "I submit an invalid password" do
          fill_in 'password_credential_password', with: ''
          click_button 'Update'
        end

        Then "I should see an alert message" do
          expect_error_message "1 error was found while updating your profile"
        end
      end
    end



  end
end