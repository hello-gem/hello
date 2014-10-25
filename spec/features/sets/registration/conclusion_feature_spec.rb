require 'spec_helper'

describe "Feature Set: Registration" do
  feature_www "Conclusion",
          who:  "As a Novice",
          what: "I want to become a User",
          why:  "So I have access to the rest of the website" do

    scenario "Success" do
      sign_up_as_a_novice
      expect(User.last.role).to eq('novice')

      click_button "Continue"

      expect(current_path).to eq '/hello/user'
      expect(User.last.role).to eq('user')
    end

  end
end
