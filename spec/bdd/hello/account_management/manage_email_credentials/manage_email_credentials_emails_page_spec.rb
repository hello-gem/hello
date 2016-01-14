require 'spec_helper'

RSpec.bdd.uic "Emails Page" do



  def self._before__given_I_am_on_the_emails_page
    before do
      Given "I am fully authorized on the Email Management Page" do
        given_I_have_signed_in_with_sudo_mode
        click_link "Settings"
        click_link "Emails"
      end
    end
  end



  story "Add" do
    _before__given_I_am_on_the_emails_page



    def _when_I_submit(text, email)
      When "I submit #{text} email" do
        fill_in 'email_credential_email', with: (@new_email = email)
        click_button 'Add'
      end
    end



    scenario "Valid" do
      _when_I_submit "a valid", "newemail@provider.com"

      Then "I should see a confirmation message" do
        expect_flash_notice "Your email was successfully added."
      end

      Then "and I should see the newly included unconfirmed email on the list" do
        within all("table tr")[1] do
          expect_to_see @new_email
          expect_to_see "Confirmation never sent"
        end
      end
    end



    scenario "Blank" do
      _when_I_submit "a blank", ""

      Then "I should see an alert message" do
        expect_flash_alert "Email can't be blank"
      end
    end



    scenario "Malformed" do
      _when_I_submit "a malformed", "a@a"

      Then "I should see an alert message" do
        expect_flash_alert "Email is too short (minimum is 4 characters)"
      end
    end



    scenario "Taken" do
      _when_I_submit "a malformed", USER_TEST_EMAIL

      Then "I should see an alert message" do
        expect_flash_alert "Email has already been taken"
      end
    end
  end



  story "Remove" do
    _before__given_I_am_on_the_emails_page



    scenario "Cannot remove single email" do
      But "I only have 1 email" do
        # empty
      end

      When "I attempt to remove that email" do
        click_on "Remove"
      end

      Then "I should see an alert message" do
        expect_flash_alert "must have at least one credential"
      end

      Then "and I should still see that email on the list" do
        within all("table tr")[0] do
          expect_to_see USER_TEST_EMAIL
          expect_to_see "Confirmation never sent"
        end
      end
    end



    scenario "Can remove a second email" do
      And "I have a second email" do
        @new_email = "newemail@provider.com"
        create(:email_credential, user: User.last, email: @new_email)
        page_reload
      end

      When "I attempt to remove that email" do
        click_nth_button("Remove", 1)
      end

      Then "I should see a confirmation message" do
        expect_flash_notice "Your email was successfully removed."
      end

      Then "and I should no longer see that email on the list" do
        expect_not_to_see @new_email
      end

      Then "nor in the database" do
        expect(Credential.pluck(:email)).not_to include @new_email
      end
    end
  end



  story "Send Confirmation" do
    _before__given_I_am_on_the_emails_page



    scenario "Success" do

      expect_any_instance_of(Hello::SendConfirmationEmailEntity).to receive(:deliver).and_call_original

      When "I click the confirm button" do
        click_button "Confirm"
      end

      Then "I should see a confirmation message" do
        expect_flash_notice "We have sent a confirmation email to #{USER_TEST_EMAIL}"
      end

      Then "and I should see the confirmation button" do
        expect(page).to have_button("Confirm")
      end

      Then "and I should see the confirmation email was recently sent" do
        expect_to_see "less than a minute ago"
      end

      Then "and an email should be sent" do
        # empty
      end

    end
  end



  story "Confirm" do
    context "Who: As a User" do
      scenario "Invalid Link" do
        given_I_have_signed_in
        _when_visit_invalid
        _then_error_message_and_signed_out
      end



      scenario "Valid Link" do
        given_I_have_signed_in
        _when_visit_valid
        _then_confirmed_and_signed_in
      end
    end



    context "Who: As a Guest" do
      scenario "Invalid Link" do
        given_I_have_not_signed_in
        _when_visit_invalid
        _then_error_message_and_signed_out
      end



      scenario "Valid Link" do
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
        @credential = create(:email_credential)
        token       = @credential.reset_verifying_token!
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
