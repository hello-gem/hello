require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Registration", "Sign Out", "Unlinked" do



    sstory "Valid" do
      sscenario "Success" do
        given_I_have_signed_in
        
        When "I get unlinked" do
          AccessToken.destroy_all
        end

        Then "I should be sent to the sign in page" do
          visit hello.current_user_path
          then_I_expect_to_be_signed_out
          expect(current_path).to eq hello.sign_in_path
        end

        Then "and see an authentication alert" do
          expect_flash_alert "You must sign in to continue."
        end
      end
    end



  end
end
