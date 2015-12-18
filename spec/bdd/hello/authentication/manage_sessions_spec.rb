require 'spec_helper'

RSpec.bdd.capability 'I can Manage Sessions' do

  role 'User' do
    Given 'I am a User' do
      sign_in_as_a('user')
      expect_to_see 'dummy-accounts-1'
    end

    context 'I can Add Sessions' do

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

    end # context

    context 'I can Switch Sessions' do

      context 'Components', type: :feature do

        uic 'Switch Button' do

          story 'Has One Account' do

            Given 'I am signed in with a single account' do
              # intentionally left blank
            end

            scenario 'Success' do

              When 'I visit Switch Accounts' do
                click_link 'Switch Accounts'
              end

              Then 'I should not see a button to switch accounts' do
                expect(page).not_to have_link('Switch!')
              end

              Then 'I should be signed in with 1 session' do
                expect_to_see 'dummy-accounts-1'
              end

              Then 'and I should be signed in' do
                then_I_expect_to_be_signed_in
              end

            end # scenario

          end # story

          story 'Has Two Accounts' do

            Given 'I sign in as a second user' do
              u = create(:user_user, username: 'foobar')
              sign_in_with(u.username)
              expect_to_see 'dummy-accounts-2'
            end

            Given 'I visit "Switch Accounts"' do
              click_link 'Switch Accounts'
              # ensuring url_for context and to_param
              expect(page.html).to include(%{<a href="/users/foobar">foobar</a>})
            end

            scenario 'Success' do

              When 'I attempt to switch to another account' do
                click_link 'Switch!'
              end

              Then 'I should see a confirmation message' do
                expect_flash_notice 'Switched Accounts Successfully!'
              end

              Then 'I should be signed in as my first account now' do
                then_I_expect_to_be_signed_in_with_role('user')
              end

            end # scenario

            scenario 'Not Found' do

              But 'My first session was dropped from the database' do
                Access.first.destroy!
              end

              When 'I attempt to switch to my first session' do
                click_link 'Switch!'
              end

              Then 'I should see an expiration message' do
                expect_flash_notice 'Your Session Was Expired!'
              end

              Then 'I should be signed in as my first account now' do
                then_I_expect_to_be_signed_in_with_role('user')
              end

            end # scenario

          end # story

        end # uic

      end # context

      api 'API', type: :request do

        skip 'TODO: write API features here too'

      end # api

    end # context

    context 'I can Forget Sessions' do

      context 'Components', type: :feature do

        uic 'Forget Button' do

          story "Has One Account" do

            Given 'I am signed in with a single account' do
              # intentionally left blank
            end

            scenario 'Success' do

              When "I attempt to forget my first session" do
                click_link "Switch Accounts"
                click_button "Forget"
              end

              Then "I should see a confirmation message" do
                expect_flash_notice 'Forgotten'
              end

              Then 'I should be signed in with 0 sessions' do
                expect_to_see 'dummy-accounts-0'
              end

              Then 'and I should be signed out' do
                then_I_expect_to_be_signed_out
              end

            end # scenario

          end # story

          story "Has Two Accounts" do

            Given 'I sign in as a second user' do
              u = create(:user_user, username: 'foobar')
              sign_in_with(u.username)
              expect_to_see "dummy-accounts-2"
            end

            scenario 'Success' do

              When "I attempt to forget my first session" do
                click_link "Switch Accounts"
                click_nth_button("Forget", 1)
              end

              Then "I should see a confirmation message" do
                expect_flash_notice 'Forgotten'
              end

              Then 'I should be signed in with 1 session' do
                expect_to_see 'dummy-accounts-1'
              end

              Then 'and I should be signed in' do
                then_I_expect_to_be_signed_in
              end

            end # scenario

          end # story

        end # uic

      end # context

      api 'API', type: :request do

        skip 'TODO: write API features here too'

      end # api

    end # context

  end # role

end # capability
