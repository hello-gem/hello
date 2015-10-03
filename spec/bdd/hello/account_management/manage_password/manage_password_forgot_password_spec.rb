require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Account Management", "Manage Password", "Forgot Password" do



    sstory "-" do



      before do
        given_I_have_an_email_credential
      end



      sscenario "Credentials Found" do
        When "I submit a valid email" do
          when_I_ask_to_reset_my_password
        end



        Then "I should see a confirmation message" do
          expect_to_see "To get back into your account, follow the instructions we've sent to your \"foobar\" email address."
          expect(current_path).to eq hello.forgot_passwords_path
        end



        Then "and I should receive an email with a password reset URL" do
          regexp = Regexp.new(/hello\/passwords\/(\d*)\/reset\/(\d*)\/\w*/)
          expect(open_last_email.to_s).to match regexp
          # TODO: test this for a valid route
        end
      end



      sscenario "Credentials Not Found" do
        When "I submit an invalid email" do
          when_I_ask_to_reset_my_password('wrong')
        end



        Then "I should see an alert message" do
          expect_error_message "1 error was found while locating your credentials"
          expect(current_path).to eq hello.forgot_passwords_path
        end
      end
    end



    after do
      then_I_expect_to_be_signed_out
    end



  end
end
