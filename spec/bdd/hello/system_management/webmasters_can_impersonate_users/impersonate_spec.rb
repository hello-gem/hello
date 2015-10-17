require 'spec_helper'

RSpec.bdd.uic "From the webmaster dashboard" do

  Given "I have signed in as a webmaster" do
    given_I_have_signed_in_as_a_webmaster

    @credential = given_I_have_an_email_credential
    visit hello.webmaster_path
    click_link "Users"
  end

  story "Impersonate" do
    # ACCEPTANCE CRITERIA
    # 1 Flash Message
    # 2 Roled as 'user'
    # 3 Enables Sudo Mode

    scenario "Success" do
      _impersonate
    end

    scenario "Stateless" do
      skip "provide scenario for an API usage with a JSON return"
    end

    scenario "Failure" do
      skip "provide scenario on how an impersonation can go wrong"
    end
  end

  story "Back to Self" do
    # ACCEPTANCE CRITERIA
    # 1 Flash Message
    # 2 Roled as 'webmaster'
    # 3 Disables Sudo Mode

    scenario "Success" do
      Given "I have impersonated a user" do
        _impersonate
      end

      When "I attempt to go back to myself" do
        click_link 'Back to Myself'
      end

      Then "I should see a confirmation message" do
        expect_flash_notice "You are yourself again"
      end

      then_I_should_be_logged_in_as_a_webmaster

      then_I_expect_not_to_be_on_sudo_mode
    end

    scenario "Failure" do
      skip "provide scenario on how an back to self can go wrong"
    end
  end



  def _impersonate
    When "I attempt to impersonate them" do
      click_button 'Impersonate!'
    end

    Then "I should see a confirmation message" do
      expect_flash_notice "You are now #{@credential.user.name}"
    end

    then_I_expect_to_be_signed_in_with_role('user')

    then_I_expect_to_be_on_sudo_mode
  end
end
