require 'spec_helper'

RSpec.bdd.uic "Unlink" do

  story "Valid" do
    scenario "Success" do
      given_I_have_signed_in_with_sudo_mode

      Given "I have a second device signed in" do
        create(:valid_access, user: User.last)
        expect(Access.count).to eq(2)
      end

      When "I attempt to unlink it" do
        click_link "Settings"
        click_link "Sessions (2)"
        click_button "Unlink"
      end

      Then "I should see a confirmation message" do
        expect_flash_notice("Device has been unlinked from your account")
      end

      Then "and it should be removed from the database" do
        expect(Access.count).to eq(1)
      end
    end
  end

end
