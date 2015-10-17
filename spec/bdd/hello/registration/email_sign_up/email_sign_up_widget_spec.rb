require 'spec_helper'

RSpec.bdd.uic "Widget" do

  scenario "Empty Form" do
    Given "The browser is a widget" do
      visit "/hello/sign_up/widget"
      expect_not_to_have_a_layout
    end

    When "I sign up with an empty form" do
      click_button 'Sign Up'
    end

    Then "I should see an error message" do
      expect_to_see "found while trying to sign up"
    end

    Then "and be on the sign up page" do
      expect(current_path).to eq hello.sign_up_path
    end

    Then "and it should no longer be a widget" do
      expect_to_have_a_layout
    end
  end

end
