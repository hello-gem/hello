require 'spec_helper'

RSpec.bdd.uic "From the webmaster dashboard" do

  Given "I have signed in as a webmaster" do
    given_I_have_signed_in_as_a_webmaster
    expect_to_see "dummy-accounts-1"

    @credential = given_I_have_an_email_credential
    visit '/'
    click_link "User List"
    click_link "View User List as a Webmaster"
  end

  story "Impersonate" do
    # ACCEPTANCE CRITERIA
    # 1 Flash Message
    # 2 Roled as 'user'
    # 3 Enables Sudo Mode

    scenario "Success" do
      When "I attempt to impersonate them" do
        click_button 'Impersonate!'
      end

      Then "I should see a confirmation message" do
        expect_flash_notice "You have signed in successfully"
      end

      then_I_expect_to_be_signed_in_with_role('user')

      then_I_expect_to_be_on_sudo_mode

      Then "I should be signed in with 2 accounts" do
        expect_to_see "dummy-accounts-2"
      end
    end

    scenario "Stateless" do
      skip "provide scenario for an API usage with a JSON return"
    end

    scenario "Failure" do
      skip "provide scenario on how an impersonation can go wrong"
    end
  end

end
