require 'spec_helper'

RSpec.bdd.capability 'I can Sign Out' do

  role 'User' do
    Given 'I am a User' do
      sign_in_as_a('user')
      expect(Access.count).to eq(1)
    end

    context 'Components', type: :feature do

      uic 'Sign Out Button' do

        scenario 'One Account' do

          Given 'I am signed in with a single account' do
            # intentionally left blank
          end

          When 'I attempt to sign out' do
            click_link 'Sign Out'
          end

          Then 'I should see a confirmation message' do
            expect_flash_notice 'You have signed out!'
          end

          Then 'and I should be signed out' do
            then_I_expect_to_be_signed_out
          end

          Then 'Database now has 0 Access' do
            expect(Access.count).to eq(0)
          end

        end # scenario

        scenario 'Two Accounts' do

          Given 'I sign in as a second user' do
            u = create(:user_user, username: 'foobar')
            sign_in_with(u.username)
            expect(Access.count).to eq(2)
          end

          When 'I attempt to sign out' do
            click_link 'Sign Out'
          end

          Then 'I should see a confirmation message' do
            expect_flash_notice 'You have signed out!'
          end

          Then 'and I should be signed in' do
            then_I_expect_to_be_signed_in
          end

          Then 'Database now has 1 Access' do
            expect(Access.count).to eq(1)
          end

        end # scenario

      end # uic

    end # context

    context 'Features', type: :feature do

      feature 'Token Expiration' do

        scenario 'Does not renew after 09 minutes' do

          When 'I visit the home page after 09 minutes' do
            visit_path_after(root_path, 9.minutes)
          end

          Then 'I should be signed in' do
            then_I_expect_to_be_signed_in
          end

          Then 'My access should expire in less than 29 minutes' do
            expect(current_access.reload.expires_at).not_to be > 29.minutes.from_now
          end

        end # scenario

        scenario 'Renews after 11 minutes' do

          When 'I visit the home page after 11 minutes' do
            visit_path_after(root_path, 11.minutes)
          end

          Then 'I should be signed in' do
            then_I_expect_to_be_signed_in
          end

          Then 'My access should expire in more than 29 minutes' do
            expect(current_access.reload.expires_at).to be > 29.minutes.from_now
          end

        end # scenario

        scenario 'Expires after 31 minutes' do

          When 'I visit the home page after 31 minutes' do
            visit_path_after(root_path, 31.minutes)
          end

          Then 'I should be signed out' do
            then_I_expect_to_be_signed_out
          end

          Then 'My access should have expired' do
            expect(Access.count).to eq(0)
          end

        end # scenario

      end # feature

      feature 'Unlinked', type: :feature do

        scenario 'One Access' do

          Given 'I should be signed in' do
            visit '/'
            then_I_expect_to_be_signed_in
          end

          When 'I get unlinked' do
            Access.destroy_all
            visit hello.current_user_path
          end

          Then 'I should be signed out' do
            then_I_expect_to_be_signed_out
          end

          Then 'I should be sent to the sign in page' do
            expect_to_be_on hello.sign_in_path
          end

        end # scenario

      end # feature

    end # context

    api 'API', type: :request do

      skip 'TODO: write API features here too'

    end # api

  end # role

end # capability
