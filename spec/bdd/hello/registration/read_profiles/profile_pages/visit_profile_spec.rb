require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Registration", "Read Profiles", "Profile Pages" do
    sstory "There are many ways to visit the profile pages" do
      sscenario "As a Guest" do
        visit root_path
        given_I_have_not_signed_in
        given_I_have_a_classic_credential # seeds a user

        _then_I_can_navigate_to_the_user_list

        _then_I_can_navigate_to_a_user
      end



      sscenario "Via Navigation Bar" do
        given_I_have_signed_in

        Then "I should be able to navigate to 'My Profile'" do
          click_link "Settings" # we visit a /hello/ URL to ensure safety with a bug on mountable engine helpers
          click_link "My Profile"
          _expect_to_be_on_foobar
        end

        _then_I_can_navigate_to_the_user_list

        _then_I_can_navigate_to_a_user
      end



      sscenario "Via Direct Link" do
        given_I_have_signed_in

        Then "I should be able to visit /users" do
          visit "/users"
          _expect_to_be_on_users
        end

        And "to visit /users/foobar" do
          visit "/users/foobar"
          _expect_to_be_on_foobar
        end
      end



      def _then_I_can_navigate_to_the_user_list
        Then "I should be able to navigate to 'User List'" do
          click_link "User List"
          _expect_to_be_on_users
        end
      end

      def _then_I_can_navigate_to_a_user
        Then "I should be able to navigate to a user" do
          click_link "foobar"
          _expect_to_be_on_foobar
        end
      end

      def _expect_to_be_on_users
        expect_to_be_on users_path
        expect_to_see "Listing Users"
      end

      def _expect_to_be_on_foobar
        expect_to_be_on "/users/foobar"
        expect_to_see "James Pinto"
      end
    end
  end
end
