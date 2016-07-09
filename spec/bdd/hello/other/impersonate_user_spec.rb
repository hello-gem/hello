require 'spec_helper'

RSpec.bdd.capability "I can Impersonate Users" do

  role "Webmaster" do
    context "Components", type: :feature do

      Given "I am a Webmaster" do
        sign_in_as_a('webmaster')
        expect_to_see "dummy-accounts-1"
      end

      uic "Users List Webmaster Page" do

        Given "a user James exists" do
          create(:user, id: 1234, username: 'james')
        end

        scenario "Success" do
          Given 'I visit Users List Webmaster Page with Sudo Mode' do
            visit '/users'
            click_link "View User List as a Webmaster"
          end

          Given 'I go through sudo mode' do
            fill_in 'user_password', with: '1234'
            click_button 'Confirm'
          end

          When "I attempt to impersonate James" do
            click_button 'Impersonate!'
          end

          Then "I should see a confirmation message" do
            expect_flash_notice "You have signed in successfully"
          end

          Then "I should be signed in as a User" do
            then_I_should_see "dummy-logged-in-role-user"
          end

          Then "I should be signed in with Sudo Mode" do
            then_I_should_see "dummy-logged-in-with-sudo-mode"
          end

          Then "I should be signed in with 2 accounts" do
            expect_to_see "dummy-accounts-2"
          end
        end # scenario


      end # uic
    end # context

  end # role

end # capability
