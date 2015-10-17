require 'spec_helper'

RSpec.bdd.uic "Dual Form" do

  scenario "Empty Form" do
    When "I sign in with an empty form" do
      visit hello.root_path
      click_button 'Sign In'
    end

    Then "I should see an error message" do
      expect_to_see "found while trying to sign in"
    end

    Then "and be on the sign in page" do
      expect(current_path).to eq hello.sign_in_path
    end
  end



end
