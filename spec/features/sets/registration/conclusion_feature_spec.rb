require 'spec_helper'

describe "Feature Set: Registration" do
  feature_www "Conclusion",
          who:  "As a Novice",
          what: "I want to become a User",
          why:  "So I have access to the rest of the website" do

    before do
      sign_up_as_a_novice
      expect(User.last.role).to eq('novice')
    end

    scenario "Success" do
      click_button "Continue"

      expect(current_path).to eq '/hello/user'
      expect(User.last.role).to eq('user')
      expect_not_to_see("You have already signed in.")
    end

    scenario "Failure" do
      uncheck "I agree"
      click_button "Continue"

      expect(current_path).to eq '/novice'
      expect(User.last.role).to eq('novice')
    end

  end
end
