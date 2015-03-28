require 'spec_helper'

RSpec.describe "Top Feature Set: Admin", :type => :feature do
  context "Feature Set: Impersonation" do

    def _impersonate
      given_I_have_signed_in_as_an_admin

      Given "I visit a user's profile page" do
        @credential = given_I_have_a_classic_credential
        # visit profile_path(credential.username)
        visit profile_path('foobar')
      end

      When "I click 'Impersonate'" do
        click_button 'Impersonate'
      end

      Then "I should see a confirmation message" do
        expect_flash_notice "You are now #{@credential.user.name}"
      end

      then_I_expect_to_be_signed_in_with_role('user')

      then_I_expect_to_be_on_sudo_mode
    end

    feature "Feature: Impersonate" do
      scenario "Scenario: Success" do
        _impersonate
      end

      scenario "Scenario: Failure" do
        skip "provide scenario on how an impersonation can go wrong"
      end

    end

    feature "Feature: Back to Self" do

      scenario "Scenario: Success" do
        Given "[I have impersonated a user]" do
          _impersonate
        end
        
        When "I click 'Back to Myself'" do
          click_link 'Back to Myself'
        end

        Then "I should see a confirmation message" do
          expect_flash_notice "You are yourself again"
        end

        then_I_should_be_logged_in_as_an_admin

        then_I_expect_not_to_be_on_sudo_mode
      end

      scenario "Scenario: Failure" do
        skip "provide scenario on how an back to self can go wrong"
      end
    end

  end
end
