require 'spec_helper'

RSpec.describe "Feature Set: Guest Receives Email", :type => :feature do
  context "Feature: Email Confirmation" do

    def the_url(id, token)
      "http://host.com/hello/emails/#{id}/confirm/#{token}"
    end

    before do
      @credential = create(:classic_credential)
      token       = @credential.reset_email_token!
      @good_url   = the_url(@credential.id, token)
      @bad_url    = the_url(0, '1234')
    end

    context "Who: As a User" do

      scenario "Scenario: It's an invalid token" do
        Given "I am logged in" do
          given_I_am_logged_in
        end
        When "I visit a bad URL" do
          visit @bad_url
        end
        Then "I should see the link has expired" do
          expect_flash_alert "This link has expired, please ask for a new link"
        end
        Then "I should be logged out" do
          then_I_should_be_logged_out
        end
      end

      scenario "Scenario: It's a valid token" do
        Given "I am logged in" do
          given_I_am_logged_in
        end
        When "I visit a good URL" do
          visit @good_url
        end
        Then "I should see a confirmation message" do
          expect_flash_notice "#{@credential.email} has been confirmed successfully."
        end
        Then "I should be logged in as a different user" do
          then_I_should_not_see "dummy-logged-in-User##{current_user.id}"
          then_I_should_see     "dummy-logged-in-User##{@credential.user_id}"
        end
      end

    end

    context "Who: As a Guest" do

      scenario "Scenario: It's an invalid token" do
        When "I visit a bad URL" do
          visit @bad_url
        end
        Then "I should see the link has expired" do
          expect_flash_alert "This link has expired, please ask for a new link"
        end
        Then "I should be logged out" do
          then_I_should_be_logged_out
        end
      end

      scenario "Scenario: It's a valid token" do
        When "I visit a good URL" do
          visit @good_url
        end
        Then "I should see a confirmation message" do
          expect_flash_notice "#{@credential.email} has been confirmed successfully."
        end
        Then "I should be logged in" do
          then_I_should_see "dummy-logged-in-User##{@credential.user_id}"
        end
      end


    end

  end
end