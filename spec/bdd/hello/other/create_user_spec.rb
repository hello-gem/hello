require 'spec_helper'

RSpec.bdd.capability "I can Create Users" do

  role "Webmaster" do
    context "Components", type: :feature do

      Given "I am a Webmaster" do
        sign_in_as_a('webmaster')
        expect_to_see "dummy-accounts-1"
      end

      uic "New User Webmaster Page" do

        Given "a user James exists" do
          create(:user, id: 1234, username: 'james')
        end

        Given 'I visit New User Webmaster Page with Sudo Mode' do
          visit '/'
          click_link 'User List'
          click_link "View User List as a Webmaster"
          fill_in 'user_password', with: '1234'
          click_button 'Confirm'
          click_link "New User as a Webmaster"
        end

        scenario "Success" do

          When 'I submit a new user John' do
            fill_in 'user_city', with: 'Brasilia'
            fill_in 'user_name', with: 'john'
            fill_in 'user_username', with: 'john'
            fill_in 'user_email', with: 'john@test.com'
            fill_in 'user_password', with: '1234'
            click_button 'Create'
          end

          Then "I should see a confirmation message" do
            expect_flash_notice 'You have signed up successfully'
          end

          Then "There should be 3 users in the database" do
            expect(User.count).to eq(3)
          end
        end # scenario


        scenario "Failure" do

          When 'I submit a new user James' do
            # fill_in 'user_password', with: '1234'
            click_button 'Create'
          end

          Then "I should see an error message" do
            expect_to_see "errors were"
          end

          Then "There should be 2 users in the database" do
            expect(User.count).to eq(2)
          end
        end # scenario

      end # uic
    end # context

  end # role

end # capability
