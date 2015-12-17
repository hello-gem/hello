require 'spec_helper'

RSpec.bdd.uic "Forget Account Button" do

  story "Has One Account" do
    before(:each) do
      Given "I have singed in with one account" do
        given_I_have_signed_in
        expect_to_see "dummy-accounts-1"
      end
    end

    scenario "Success" do
      When "I attempt to sign out from one of my accounts" do
        click_link "Switch Accounts"
        click_button "Forget"
      end

      Then "I should see a confirmation message" do
        expect_flash_notice 'Forgotten'
      end

      then_I_expect_to_be_signed_out

      Then "I should be on the accounts page" do
        expect_to_be_on '/hello/sessions'
      end

      Then "my access token should be removed from the database" do
        expect(User.count).to        eq(1)
        expect(Credential.count).to  eq(2)
        expect(Access.count).to      eq(0)
      end
    end
  end

  story "Has Two Accounts" do
    before(:each) do
      Given "I have singed in with two accounts" do
        given_I_am_logged_in_with_two_accounts
      end
    end

    scenario "Success" do
      When "I attempt to sign out from one of my accounts" do
        click_link "Switch Accounts"
        click_nth_button("Forget", 1)
      end

      Then "I should see a confirmation message" do
        expect_flash_notice 'Forgotten'
      end

      then_I_expect_to_be_signed_out

      Then "I should be on the accounts page" do
        expect_to_be_on '/hello/sessions'
      end

      Then "my access token should be removed from the database" do
        expect(User.count).to        eq(2)
        expect(Credential.count).to  eq(4)
        expect(Access.count).to      eq(1)
      end
    end
  end



end
