require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Authentication", "Email Sign In", "Single Form" do



    def get_last_access
      Access.last
    end



    ccontext "Valid Scenarios" do



      before do
        given_I_have_an_email_credential
      end

      def _then_I_should_see_a_confirmation_message
        Then "I should see a confirmation message" do
          expect_flash_notice "You have signed in successfully"
        end
      end

      def _and_be_signed_in_for(s, t)
        Then "and be signed in for #{s}" do
          then_I_should_be_logged_in
          expect(get_last_access.expires_at).to be > t.from_now
        end
      end

      def _and_be_sent_to_the_url(title, url)
        Then "and be sent to the #{title} URL" do
          expect(current_path).to eq url
        end
      end



      sscenario "Valid Email & Password" do
        When "I sign in with valid Email & Password" do
          when_sign_in('foo@bar.com', 'foobar')
        end

        _then_I_should_see_a_confirmation_message

        _and_be_signed_in_for("30 minutes", 29.minutes)

        _and_be_sent_to_the_url('root', '/')
      end



      sscenario "Valid Username & Password" do
        When "I sign in with valid Username & Password" do
          when_sign_in('foobar', 'foobar')
        end

        _then_I_should_see_a_confirmation_message

        _and_be_signed_in_for("30 minutes", 29.minutes)

        _and_be_sent_to_the_url('root', '/')
      end



      sscenario "Previous URL" do
        Given "I was asked to sign in upon visiting a URL" do
          visit @url = hello.current_user_path
          expect(current_path).to eq hello.sign_in_path
        end

        When "I sign in with valid credentials" do
          when_sign_in_with_standard_data
        end

        _then_I_should_see_a_confirmation_message

        _and_be_signed_in_for("30 minutes", 29.minutes)

        _and_be_sent_to_the_url('previous', @url)
      end



      sscenario "Keep me" do
        When "I sign in with valid credentials checking 'keep me'" do
          when_sign_in_with_standard_data(keep_me: true)
        end

        _then_I_should_see_a_confirmation_message

        _and_be_signed_in_for("30 days", 29.days)

        _and_be_sent_to_the_url('root', '/')
      end



    end






    ccontext "Invalid Scenarios" do



      def _and_be_signed_out
        Then "and be signed out" do
          then_I_should_be_logged_out
        end
      end

      def _then_I_should_see_a_login_alert
        Then "I should see a login alert" do
          expect_error_message "1 error was found while trying to sign in"
          expect_to_see "This login was not found in our database."
        end
      end

      def _and_a_suggestion_to_sign_up
        Then "and a suggestion to sign up" do
          expect_to_see "Do you want to Sign Up instead?"
        end
      end

      def _then_I_should_see_a_password_alert
        Then "I should see a password alert" do
          expect_error_message "1 error was found while trying to sign in"
          expect_to_see "Your password does not match that in our database."
        end
      end

      def _and_a_suggestion_to_reset_password
        Then "and a suggestion to reset password" do
          expect_to_see "Did you forget your password?"
        end
      end

      def _on_the_sign_in_path
        Then "on the sign in page" do
          expect(current_path).to eq hello.sign_in_path
        end
      end

      def _but_no_password_alerts
        Then "but no password alerts" do
          expect_not_to_see "Your password does not match that in our database."
        end
      end



      sscenario "Empty Form" do
        When "I sign in with an empty form" do
          visit hello.root_path
          click_button 'Sign In'
        end

        _then_I_should_see_a_login_alert
        _and_a_suggestion_to_sign_up
        _and_be_signed_out
        _on_the_sign_in_path
        _but_no_password_alerts
      end



      sscenario "Email not found" do
        When "I sign in with an invalid email" do
          when_sign_in("dont@exist.com", "foobar")
        end

        _then_I_should_see_a_login_alert
        _and_a_suggestion_to_sign_up
        _and_be_signed_out
        _on_the_sign_in_path
        _but_no_password_alerts
      end



      sscenario "Username not found" do
        When "I sign in with an invalid username" do
          when_sign_in("dontexist", "foobar")
        end

        _then_I_should_see_a_login_alert
        _and_a_suggestion_to_sign_up
        _and_be_signed_out
        _on_the_sign_in_path
        _but_no_password_alerts
      end



      sscenario "Wrong Password" do
        When "I sign in with a wrong password" do
          given_I_have_an_email_credential
          when_sign_in("foobar", "wrong")
        end

        _then_I_should_see_a_password_alert
        _and_a_suggestion_to_reset_password
        _and_be_signed_out
        _on_the_sign_in_path
      end



      sscenario "Blank Password" do
        When "I sign in with a wrong password" do
          given_I_have_an_email_credential
          when_sign_in("foobar", "")
        end

        _then_I_should_see_a_password_alert
        _and_a_suggestion_to_reset_password
        _and_be_signed_out
        _on_the_sign_in_path
      end



    end



  end
end
