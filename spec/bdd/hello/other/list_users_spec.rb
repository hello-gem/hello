require 'spec_helper'

RSpec.bdd.capability "I can List Users" do

  %w[guest onboarding user webmaster].each do |role_string|
    role role_string.titleize do
      context "Components", type: :feature do

        Given "I am a #{role_string.titleize}" do
          sign_in_as_a(role_string)
        end

        uic "User List Page" do

          scenario 'I have access to the page' do

            When 'I visit the users page' do
              visit '/'
              click_link 'User List'
            end

            Then 'I should be on the users page' do
              expect_to_be_on('/users')
            end

          end # scenario

        end # uic

        uic "User Page" do

          Given "a user James exists" do
            create(:user, id: 1234, username: 'james')
          end

          story "Accessing the page" do

            scenario "Via User List Page" do
              When 'I visit james profile from the User List page' do
                visit '/'
                click_link 'User List'
                click_link 'james'
              end
            end # scenario

            scenario "Via Direct Link" do
              When "I visit james profile from a direct link" do
                visit "/users/james"
              end
            end # scenario

          end # story

          story "Redirects to username" do

            scenario "Visits ID route" do
              When "I visit the ID route" do
                visit "/users/1234"
              end
            end # scenario

            scenario "Visits username route" do
              When "I visit the username route" do
                visit "/users/james"
              end
            end # scenario

          end # story

          Then "I should be on james username route" do
            expect_to_be_on '/users/james'
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
