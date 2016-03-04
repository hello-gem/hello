require 'spec_helper'

RSpec.bdd.capability "I can Cancel my Account" do

  # TODO: test with onboarding too

  %w[user webmaster].each do |role_string|
    role role_string.titleize do
      context "Components", type: :feature do

        Given "I am a #{role_string.titleize}" do
          sign_in_as_a(role_string)
        end

        uic "Cancel Account Page" do

          Given "I visit the Cancel Account Page" do
            visit '/'
            click_link 'Settings'
            click_link 'Cancel Account'
          end

          Given 'I go through sudo mode' do
            fill_in 'user_password', with: '1234'
            click_button 'Confirm'
          end

          story "Valid" do

            scenario "Success" do

              And "User has no dependent children" do
              end

              When 'I attempt to cancel my account' do
                click_button 'Cancel'
              end

              Then "I should be on the home page" do
                expect_to_be_on '/'
              end

              Then "I should see a confirmation message" do
                expect_flash_notice "You have deactivated your account successfully"
              end

              Then "and I should be signed out" do
                then_I_expect_to_be_signed_out
              end

              Then "and my data should be removed from the database" do
                expect(User.count).to        eq(0)
                expect(Credential.count).to  eq(0)
                expect(Access.count).to      eq(0)
              end

            end # scenario

          end # story

          story "Invalid" do

            scenario "User has dependent children" do
              But "User has dependent children" do
                User.last.addresses.create! text: "foo"
              end

              When 'I attempt to cancel my account' do
                click_button 'Cancel'
              end
            end

            scenario "User has dependent grandchildren" do
              But "User has dependent grandchildren" do
                Credential.last.some_credential_data.create! text: "foo"
              end

              When 'I attempt to cancel my account' do
                click_button 'Cancel'
              end
            end

            Then "I should be back on the Cancel Account page" do
              expect_to_be_on '/hello/cancel_account'
            end

            Then "I should see an error message" do
              expect_flash_alert "Terminating your account would cause other users to experience errors while using our website. Please contact any of our staff members and ask to have your account removed manually."
            end

            Then "and I should be signed in" do
              then_I_expect_to_be_signed_in
            end

            Then "and my data should be removed from the database" do
              expect(User.count).to               eq(1)
              expect(EmailCredential.count).to    eq(1)
              expect(PasswordCredential.count).to eq(1)
              expect(Access.count).to             eq(1)
            end

          end

        end # uic
      end # context


      context "API", type: :request do
        api "API" do
          skip "ToDo: write API features here too"
        end
      end # context

    end # role
  end

end # capability
