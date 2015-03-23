require 'spec_helper'

RSpec.describe "Feature Set: Guest Receives Email", :type => :feature do
  context "Feature: Email Confirmation" do

    context "Who: As a User" do

      scenario "Invalid Scenario" do
        given_I_have_signed_in
        _when_visit_invalid
        _then_error_message_and_signed_out
      end

      scenario "Valid Scenario" do
        given_I_have_signed_in
        _when_visit_valid
        _then_confirmed_and_signed_in
      end

    end




    context "Who: As a Guest" do

      scenario "Invalid Scenario" do
        given_I_have_not_signed_in
        _when_visit_invalid
        _then_error_message_and_signed_out
      end

      scenario "Valid Scenario" do
        given_I_have_not_signed_in
        _when_visit_valid
        _then_confirmed_and_signed_in
      end

    end






    def the_url(id, token)
      "http://host.com/hello/emails/#{id}/confirm/#{token}"
    end

    def _when_visit_invalid
      When "I visit an invalid token URL" do
        visit the_url(0, '1234')
      end
    end

    def _when_visit_valid
      When "I visit a valid token URL" do
        @credential = create(:classic_credential)
        token       = @credential.reset_email_token!
        visit the_url(@credential.id, token)
      end
    end

    def _then_error_message_and_signed_out
      Then "I should see the link has expired" do
        expect_flash_alert "This link has expired, please ask for a new link"
      end

      then_I_expect_to_be_signed_out
    end

    def _then_confirmed_and_signed_in
      Then "I should see a confirmation message" do
        expect_flash_notice "#{@credential.email} has been confirmed successfully."
      end

      then_I_expect_to_be_signed_in_with_id(@credential.user_id)

      Then "I expect to see the email was confirmed" do
        expect(@credential.reload.email_confirmed?).to eq(true)
      end
    end

  end
end
