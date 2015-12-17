require 'spec_helper'

RSpec.bdd.capability 'I can Forget Sessions' do

  role 'User' do
    Given 'I am a User' do
      sign_in_as_a('user')
      expect_to_see 'dummy-accounts-1'
    end

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

  end # role

end # capability
