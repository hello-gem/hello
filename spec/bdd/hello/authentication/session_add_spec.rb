require 'spec_helper'

RSpec.bdd.capability 'I can Add Sessions' do

  role 'User' do
    Given 'I am a User' do
      sign_in_as_a('user')
      expect_to_see 'dummy-accounts-1'
    end

    context 'Components', type: :feature do

      uic 'Sign In Path' do

        Given 'I visit "Switch Accounts" > "Add Account" > "Sign In"' do
          visit '/'
          click_link 'Switch Accounts'
          click_link 'Add Account'
          click_link 'Sign In'
        end

        scenario 'Success' do

          When 'I sign in as a second user' do
            u = create(:user_user, username: 'foobar')
            fill_in_login_form(u.username)
            click_button 'Sign In'
          end

          Then 'I should see a confirmation message' do
            expect_flash_notice 'You have signed in successfully'
          end

          Then 'I should be signed in with 2 sessions' do
            expect_to_see 'dummy-accounts-2'
          end

        end # scenario

        scenario 'Invalid Credentials' do

          When 'I sign in as a second user' do
            fill_in_login_form('doesnotexist')
            click_button 'Sign In'
          end

          Then "I should see a validation errors" do
            expect_error_message "1 error was found while trying to sign in"
            expect_to_see "This login was not found in our database."
          end

          Then 'I should be signed in with 1 session' do
            expect_to_see 'dummy-accounts-1'
          end

        end # scenario

      end # uic

      uic 'Sign Up Path' do

        Given 'I visit "Switch Accounts" > "Add Account" > "Sign Up"' do
          visit '/'
          click_link 'Switch Accounts'
          click_link 'Add Account'
          click_link 'Sign Up'
        end

        scenario 'Success' do

          When 'I sign up with valid data' do
            fill_in_registration_form
            click_button 'Sign Up'
          end

          Then 'I should see a confirmation message' do
            expect_flash_notice 'You have signed up successfully'
          end

          Then 'I should be signed in with 2 sessions' do
            expect_to_see 'dummy-accounts-2'
          end

        end # scenario

        scenario 'Invalid Registration' do
          When 'I sign up with invalid data' do
            click_button 'Sign Up'
          end

          Then "I should see a validation errors" do
            expect_error_message "6 errors were found while trying to sign up"
          end

          Then 'I should be signed in with 1 session' do
            expect_to_see 'dummy-accounts-1'
          end
        end

      end # uic

    end # context

    api 'API', type: :request do

      skip 'TODO: write API features here too'

    end # api

  end # role

end # capability
