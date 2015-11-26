require 'spec_helper'

RSpec.bdd.capability "I can Complete the Onboarding Process" do

  role "Onboarding" do

    uic "Onboarding Process Form", type: :feature do
      Given "I am an onboarding" do
        create(:user_onboarding)
        visit "/hello/sign_in"
        fill_in_login_form('onboarding')
        click_button 'Sign In'
        expect_to_be_on '/onboarding'
      end

      scenario "Continue As a User" do

        When "I Continue As a User" do
          click_button "Continue As a User"
        end

        Then "I should now be a User" do
          then_I_expect_to_be_signed_in_with_role('user')
        end

      end # scenario

      scenario "Continue As a Webmaster" do

        When "I Continue As a Webmaster" do
          click_button "Continue As a Webmaster"
        end

        Then "I should now be a Webmaster" do
          then_I_expect_to_be_signed_in_with_role('webmaster')
        end

      end # scenario

      Then "I should see a confirmation message" do
        expect_flash_notice "Welcome!"
      end
    end # uic

    api "API", type: :request do
      Given "I am an onboarding" do
        @access_token = create(:valid_access, user: create(:user_onboarding)).token
      end

      scenario "Continue As Invalid" do

        When "I Continue As a User" do
          post "/onboarding.json", access_token: @access_token, role: 'invalid'
        end

        Then "I should get a 422 Unprocessable Entity response" do
          expect(response_status).to eq [422, "Unprocessable Entity"]
        end

        Then "I should see error messages" do
          expect(json_response).to eq({"errors" => "invalid role supplied"})
        end

      end # scenario

      scenario "Continue As a User" do

        When "I Continue As a User" do
          post "/onboarding.json", access_token: @access_token, role: 'user'
        end

        Then "I should get a 200 OK response" do
          expect(response_status).to eq [200, "OK"]
        end

        Then "My new role should be 'user'" do
          expect(json_response['user']['role']).to eq 'user'
        end

      end # scenario

      scenario "Continue As a Webmaster" do

        When "I Continue As a User" do
          post "/onboarding.json", access_token: @access_token, role: 'webmaster'
        end

        Then "I should get a 200 OK response" do
          expect(response_status).to eq [200, "OK"]
        end

        Then "My new role should be 'webmaster'" do
          expect(json_response['user']['role']).to eq 'webmaster'
        end

      end # scenario
    end # api

  end # role

end # capability
