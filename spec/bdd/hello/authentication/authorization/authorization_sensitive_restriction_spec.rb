require 'spec_helper'

RSpec.bdd.uic "Sensitive Restriction" do

  story "Enable Sudo Mode" do
    before do
      Given "I see the Sudo Mode form" do
        given_I_have_signed_in

        click_link "Settings"
        click_link "Sessions"

        expect(page).to have_content "Confirm Password to Continue"
        expect(current_path).to eq hello.accesses_path
        expect(Access.last.sudo_expires_at).to be < Time.now
      end
    end



    scenario "Success" do
      When "I submit the correct password" do
        when_I_confirm_my_user_password
      end

      Then "and I should see a confirmation message" do
        expect_flash_notice "Now we know it's really you. We won't be asking your password again for 60 minutes"
      end

      then_I_expect_to_be_on_sudo_mode
    end



    scenario "Blank Password" do
      When "I submit an empty form" do
        when_I_confirm_my_user_password('', false)
      end

      _then_failed_to_enable_sudo_mode
    end



    scenario "Wrong Password" do
      When "I submit an incorrect password" do
        when_I_confirm_my_user_password('wrong', false)
      end

      _then_failed_to_enable_sudo_mode
    end
  end



  story "Disable Sudo Mode" do
    scenario "Success" do
      given_I_have_signed_in_with_sudo_mode

      When "I disable sudo mode" do
        click_link "expire"
      end

      Then "I should see a confirmation message" do
        expect_flash_notice "We will now ask your password for sensitive access"
      end

      then_I_expect_not_to_be_on_sudo_mode
    end
  end



  def _then_failed_to_enable_sudo_mode
    Then "I expect to see an error message" do
      expect_flash_alert "Incorrect Password"
    end

    then_I_expect_not_to_be_on_sudo_mode
  end



end
