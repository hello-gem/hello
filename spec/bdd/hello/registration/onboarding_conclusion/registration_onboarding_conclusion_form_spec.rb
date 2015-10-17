require 'spec_helper'

RSpec.bdd.uic "Form" do

  before do
    Given "I have signed up as an onboarding" do
      sign_up_as_an_onboarding
      expect(User.last.role).to eq('onboarding')
    end
  end

  scenario "Accepts the terms" do

    When "I continue and accept the terms" do
      click_button "Continue"
    end

    Then "I should see a confirmation message" do
      expect_flash_notice "Welcome!"
    end

    Then "and be signed in as a user" do
      then_I_expect_to_be_signed_in_with_role('user')
    end

  end

  scenario "Does not accept the terms" do

    When "I continue but don't accept the terms" do
      uncheck "I agree"
      click_button "Continue"
    end

    Then "I should see an error message" do
      expect_to_see "You cannot join the website unless you agree with our terms and policies"
    end

    Then "and be signed in as an onboarding" do
      then_I_expect_to_be_signed_in_with_role('onboarding')
    end

  end

end
