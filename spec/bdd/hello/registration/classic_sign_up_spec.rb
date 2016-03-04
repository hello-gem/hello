require 'spec_helper'

RSpec.bdd.capability "I can Sign Up With Email" do

  role "Guest" do
    Given "I am a Guest" do
    end

    uic "Single Form", type: :feature do
      Given "I am on the sign up page" do
        visit "/hello/sign_up"
      end

      scenario "Valid Form" do
        When "I sign up with a valid form" do
          fill_in_registration_form
          click_button 'Sign Up'
        end

        Then "I should see a confirmation message" do
          expect_flash_notice "You have signed up successfully"
        end

        Then "I should be on the onboarding page" do
          expect(User.last.role).to eq('onboarding')
          expect_to_be_on '/onboarding'
        end

        Then "Database now has 1 User, 1 Email, 1 Password, 1 Access" do
          expect(User.count).to eq(1)
          expect(EmailCredential.count).to eq(1)
          expect(PasswordCredential.count).to eq(1)
          expect(Access.count).to eq(1)
        end
      end # scenario

      scenario "Empty Form" do
        When "I sign up with an empty form" do
          click_button 'Sign Up'
        end

        Then "I should see an error message" do
          expect_error_message "errors were found while trying to sign up"
        end

        Then "I should be on the sign up page" do
          expect_to_be_on hello.sign_up_path
        end

        Then "Database now has 0 User, 0 Email, 0 Password, 0 Access" do
          expect(User.count).to eq(0)
          expect(EmailCredential.count).to eq(0)
          expect(PasswordCredential.count).to eq(0)
          expect(Access.count).to eq(0)
        end
      end # scenario
    end # uic

    uic "Dual Form", type: :feature do
      Given "I am on the hello page" do
        visit "/hello"
      end

      scenario "Valid Form" do
        skip
      end # scenario

      scenario "Empty Form" do
        When "I sign up with an empty form" do
          click_button 'Sign Up'
        end

        Then "I should see an error message" do
          expect_error_message "errors were found while trying to sign up"
        end

        Then "I should be on the sign up page" do
          expect_to_be_on hello.sign_up_path
        end

        Then "Database now has 0 User, 0 Email, 0 Password, 0 Access" do
          expect(User.count).to eq(0)
          expect(EmailCredential.count).to eq(0)
          expect(PasswordCredential.count).to eq(0)
          expect(Access.count).to eq(0)
        end
      end # scenario
    end # uic

    uic "Widget", type: :feature do
      Given "I am on the sign up widget" do
        visit "/hello/sign_up/widget"
        expect_not_to_have_a_layout
      end

      scenario "Valid Form" do
        skip
      end # scenario

      scenario "Empty Form" do
        When "I sign up with an empty form" do
          click_button 'Sign Up'
        end

        Then "I should see an error message" do
          expect_error_message "errors were found while trying to sign up"
        end

        Then "I should be on the sign up page" do
          expect_to_be_on hello.sign_up_path
        end

        Then "Database now has 0 User, 0 Email, 0 Password, 0 Access" do
          expect(User.count).to eq(0)
          expect(EmailCredential.count).to eq(0)
          expect(PasswordCredential.count).to eq(0)
          expect(Access.count).to eq(0)
        end

        Then "page should no longer be a widget" do
          expect_to_have_a_layout
        end
      end # scenario
    end # uic

    api "API", type: :request do
      scenario "Valid Parameters" do
        When "I sign up with valid parameters" do
          post "/hello/sign_up.json", sign_up: {email: "foo@bar.com", password: "foobar", name: "Foo Bar", city: "Brasilia", username: "foobar"}
        end

        Then "I should see the access object" do
          expect(json_response.keys).to match_array ["expires_at", "token", "user", "user_id"]
          expect(json_response["user"].keys).to match_array ["id", "accesses_count", "city", "created_at", "credentials_count", "locale", "name", "role", "time_zone", "updated_at", "username"]
        end

        Then "I should get a 201 response" do
          expect(response.status).to         eq(201)
          expect(response.status_message).to eq('Created')
        end

        Then "User should have onboarding role" do
          expect(json_response['user']['role']).to eq "onboarding"
        end

        Then "Database now has 1 User, 1 Email, 1 Password, 1 Access" do
          expect(User.count).to eq(1)
          expect(EmailCredential.count).to eq(1)
          expect(PasswordCredential.count).to eq(1)
          expect(Access.count).to eq(1)
        end
      end # scenario

      scenario "Blank Parameters" do
        When "I sign up with an empty parameters" do
          post "/hello/sign_up.json", sign_up: {email: ''}
        end

        Then "I should see errors" do
          expect(json_response).to eq({
            "username"=>["can't be blank"],
            "email"=>["can't be blank"],
            "password"=>["can't be blank"],
            "name"=>["can't be blank"],
            "city"=>["can't be blank"]
          })
        end

        Then "I should get a 422 response" do
          expect(response.status).to         eq(422)
          expect(response.status_message).to eq('Unprocessable Entity')
        end

        Then "Database now has 0 User, 0 Email, 0 Password, 0 Access" do
          expect(User.count).to eq(0)
          expect(EmailCredential.count).to eq(0)
          expect(PasswordCredential.count).to eq(0)
          expect(Access.count).to eq(0)
        end
      end # scenario
    end # api

  end # role

end # capability
