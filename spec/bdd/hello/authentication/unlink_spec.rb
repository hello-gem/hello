require 'spec_helper'

RSpec.bdd.capability 'I can Unlink' do

  role 'User' do
    Given 'I am a User' do
      sign_in_as_a('user')
      expect(Access.count).to eq(1)
    end

    context 'Components', type: :feature do

      uic 'Unlink Button' do

        scenario 'Two Accesses' do

          Given 'a second device has logged into my account' do
            create(:valid_access, user: current_user)
          end

          Given 'I visit the Accesses Page' do
            visit '/'
            click_link 'Settings'
            click_link 'Devices'
          end

          Given 'I go through sudo mode' do
            fill_in 'user_password', with: '1234'
            click_button 'Confirm'
          end

          Given 'I should have 2 accesses in the database but only see 1 unlink button' do
            expect(Access.where(user_id: current_user.id).count).to eq(2)
            expect(page).to have_button('Unlink', count: 1)
          end

          When 'I attempt to unlink the second device' do
            click_button 'Unlink'
          end

          Then 'I should see a confirmation message' do
            expect_flash_notice('Device has been unlinked from your account')
          end

          Then 'Database now has 1 Access' do
            expect(Access.count).to eq(1)
          end

        end # scenario

      end # uic

    end # context

    context 'Features', type: :feature do

      feature 'Unlinked' do

        scenario 'One Access' do

          Given 'I should be signed in' do
            visit '/'
            then_I_expect_to_be_signed_in
          end

          When 'I get unlinked' do
            Access.destroy_all
            visit hello.current_user_path
          end

          Then 'I should be sent to the sign in page' do
            then_I_expect_to_be_signed_out
            expect(current_path).to eq hello.sign_in_path
          end

          Then 'I should be signed out' do
            then_I_expect_to_be_signed_out
          end

        end # scenario

      end # feature

    end # context

    api 'API', type: :request do

      skip 'TODO: write API features here too'

    end # api

  end # role

end # capability
