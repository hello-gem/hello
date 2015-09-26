require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Authentication", "Sign Out", "Unlinked" do



    sstory "Valid" do
      sscenario "Success" do
        given_I_have_signed_in
        
        When "I get unlinked" do
          Access.destroy_all
        end

        Then "I should be sent to the sign in page" do
          visit hello.current_user_path
          then_I_expect_to_be_signed_out
          expect(current_path).to eq hello.sign_in_path
        end
      end
    end



  end
end
