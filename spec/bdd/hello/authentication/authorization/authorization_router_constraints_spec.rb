require 'spec_helper'

RSpec.bdd.uic "Router Constraints" do

  story "For Users" do
    scenario "As a Guest" do
      Given "I am a Guest" do
        # :)
      end

      When "I visit a route constrained to users" do
        # :)
      end

      Then "I should see a 404 error" do
        expect {
          visit "/middleware/bad_kitty"
        }.to raise_error ActionController::RoutingError
      end
    end



    scenario "As a User" do
      Given "I am a User" do
        given_I_have_signed_in
      end

      When "I visit a route constrained to users" do
        # :)
      end

      Then "I should not see a 404 error" do
        expect {
          visit "/middleware/bad_kitty"
        }.not_to raise_error
      end
    end
  end

end
