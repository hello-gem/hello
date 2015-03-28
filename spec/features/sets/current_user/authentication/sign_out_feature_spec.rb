require 'spec_helper'

RSpec.describe "Top Feature Set: Current User", :type => :feature do
  context "Feature Set: Authentication" do



    feature "Feature: Sign Out" do
      
      scenario "Scenario: Success (Only)" do
        given_I_have_signed_in

        When "I click 'Sign Out'" do
          click_link("Sign Out")
        end
        
        Then "I should see a confirmation message" do
          expect_flash_notice "You have signed out!"
        end

        then_I_expect_to_be_signed_out

        Then "I shoud be on the signed out page" do
          expect(current_path).to eq hello.sign_out_path
        end
      end
    end



  end
end