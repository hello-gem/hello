require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Authentication", "Sign Out", "Token Expiration" do



    sstory "Various time spans" do
      sscenario "Sustains at 09 minutes" do
        x_minutes_have_passed(9)
        then_I_expect_to_be_signed_in
        Then "and my token expiracy should not be renewed" do
          expect_token_not_to_be_renewed
        end
      end



      sscenario "Renews at 11 minutes" do
        x_minutes_have_passed(11)
        then_I_expect_to_be_signed_in
        Then "and my token expiracy should be renewed" do
          expect_token_to_be_renewed
        end
      end



      sscenario "Expires at 31 minutes" do
        x_minutes_have_passed(31)
        then_I_expect_to_be_signed_out
        Then "and I should be on the root page" do
          expect(current_path).to eq root_path
        end
        Then "and my access token should be removed from the database" do
          expect(User.count).to        eq(1)
          expect(Credential.count).to  eq(1)
          expect(Access.count).to      eq(0)
        end
      end
    end



    def x_minutes_have_passed(minutes)
      given_I_have_signed_in
      expect_token_to_be_renewed
      expect(my_token_expiracy).to be < 31.minutes.from_now

      When "#{minutes} minutes have passed" do
        access_token = Access.last
        expires_at = access_token.expires_at - minutes.minutes
        access_token.update_attribute :expires_at, expires_at
        visit root_path
      end
    end

    def my_token_expiracy
      Access.last.expires_at
    end

    def expect_token_to_be_renewed
      expect(my_token_expiracy).to be > 29.minutes.from_now
    end

    def expect_token_not_to_be_renewed
      expect(my_token_expiracy).not_to be > 29.minutes.from_now
    end



  end
end
