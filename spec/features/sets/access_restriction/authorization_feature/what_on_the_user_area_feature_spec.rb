require 'spec_helper'

describe "Feature Set: Access Restriction" do
  feature_www "Authorization",
          where: "On the User Area" do



    what "On the User page" do

      who "As a Guest" do
        scenario "Access Denied" do
          visit2 :guest, '/hello/sign_in', :must_be_authenticated
        end
      end

      who "As a Novice" do
        scenario "Access Denied" do
          visit2 :novice, '/novice', :cannot_be_a_novice
        end
      end

      who "As a User" do
        scenario "Access Granted" do
          visit2 :user, '/hello/user'
        end
      end

      who "As an Admin" do
        scenario "Access Granted" do
          visit2 :admin, '/hello/user'
        end
      end

      def visit2(role, expected_path, expected_flash_alert=nil)
        sign_up_as_a(role)
        visit '/hello/user'
        expect(current_path).to eq(expected_path)
        expect_flash_auth(expected_flash_alert)
      end

    end



    what "On the Credentials page" do

      who "As a Guest" do
        scenario "Access Denied" do
          visit2 :guest, '/hello/sign_in', :must_be_authenticated
        end
      end

      who "As a Novice" do
        scenario "Access Denied" do
          visit2 :novice, '/novice', :cannot_be_a_novice
        end
      end

      who "As a User" do
        scenario "Access Granted" do
          visit2 :user, "/hello/emails"
        end
      end

      who "As an Admin" do
        scenario "Access Granted" do
          visit2 :admin, "/hello/emails"
        end
      end

      def visit2(role, expected_path, expected_flash_alert=nil)
        sign_up_as_a(role)
        visit "/hello/emails"
        expect(current_path).to eq(expected_path)
        expect_flash_auth(expected_flash_alert)
      end

    end



    what "On the Access Tokens page" do

      who "As a Guest" do
        scenario "Access Denied" do
          visit2 :guest, '/hello/sign_in', :must_be_authenticated
        end
      end

      who "As a Novice" do
        scenario "Access Denied" do
          visit2 :novice, '/novice', :cannot_be_a_novice
        end
      end

      who "As a User" do
        scenario "Access Granted" do
          visit2 :user, "/hello/access_tokens"
        end
      end

      who "As an Admin" do
        scenario "Access Granted" do
          visit2 :admin, "/hello/access_tokens"
        end
      end

      def visit2(role, expected_path, expected_flash_alert=nil)
        sign_up_as_a(role)
        visit "/hello/access_tokens"
        expect(current_path).to eq(expected_path)
        expect_flash_auth(expected_flash_alert)
      end

    end



    what "On the Sudo Mode page" do

      who "As a Guest" do
        scenario "Access Denied" do
          visit2 :guest, '/hello/sign_in', :must_be_authenticated
        end
      end

      who "As a Novice" do
        scenario "Access Denied" do
          visit2 :novice, '/novice', :cannot_be_a_novice
        end
      end

      who "As a User" do
        scenario "Access Granted" do
          visit2 :user, "/hello/sudo_mode"
        end
      end

      who "As an Admin" do
        scenario "Access Granted" do
          visit2 :admin, "/hello/sudo_mode"
        end
      end

      def visit2(role, expected_path, expected_flash_alert=nil)
        sign_up_as_a(role)
        visit "/hello/sudo_mode"
        expect(current_path).to eq(expected_path)
        expect_flash_auth(expected_flash_alert)
      end

    end



    what "On the Deactivation page" do

      who "As a Guest" do
        scenario "Access Denied" do
          visit2 :guest, '/hello/sign_in', :must_be_authenticated
        end
      end

      who "As a Novice" do
        scenario "Access Granted" do
          visit2 :novice, "/hello/deactivation"
        end
      end

      who "As a User" do
        scenario "Access Granted" do
          visit2 :user, "/hello/deactivation"
        end
      end

      who "As an Admin" do
        scenario "Access Granted" do
          visit2 :admin, "/hello/deactivation"
        end
      end

      def visit2(role, expected_path, expected_flash_alert=nil)
        sign_up_as_a(role)
        visit "/hello/deactivation"
        expect(current_path).to eq(expected_path)
        expect_flash_auth(expected_flash_alert)
      end

    end



  end
end