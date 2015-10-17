require 'spec_helper'

RSpec.bdd.uic "Single Form" do

  scenario "Valid Form" do
    When "I sign up with a valid form" do
      when_sign_up_as_an_onboarding
    end

    Then "I should see a confirmation message" do
      expect_flash_notice "You have signed up successfully"
    end

    Then "and be signed up" do
      expect(User.count).to eq(1)
    end

    Then "and signed in" do
      then_I_should_be_logged_in
    end

    Then "as an onboarding" do
      expect(User.last.role).to eq('onboarding')
      expect(current_path).to eq '/onboarding'
    end
  end

  scenario "Empty Form" do
    When "I sign up with an empty form" do
      visit hello.root_path
      click_button 'Sign Up'
    end

    Then "I should see an error message" do
      expect_error_message "6 errors were found while trying to sign up"
    end

    Then "and be on the sign up page" do
      expect(current_path).to eq hello.sign_up_path
    end
  end
  #       scenario taken
  # #     given_I_have_a_classic_access_token
  # #     when_sign_up_as_an_onboarding(expect_welcome_mailer: false, expect_success: false)
  # #     expect_error_message "2 errors were found while trying to sign up"
  # #     expect_to_see "This email address has already been registered."
  # #     expect_to_see "This username has already been registered."
  # #     expect(current_path).to eq hello.sign_up_path
  # #     then_I_should_be_logged_out

end
