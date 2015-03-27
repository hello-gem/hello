module Hello::FeatureSupportGiven

  def given_I_have_not_signed_in
    Given("I have not signed in") {  }
  end

  def given_I_have_signed_in
    Given "I have signed in" do
      given_I_am_logged_in
      then_I_expect_to_be_signed_in_with_role('user')
    end
  end

  def given_I_have_signed_in_with_sudo_mode
    Given "I have signed in with sudo mode" do
      given_I_have_signed_in
      then_I_expect_not_to_be_on_sudo_mode
      visit "/hello/emails"
      when_I_confirm_sudo_mode
      then_I_expect_to_be_on_sudo_mode
    end
  end

  def given_I_have_signed_in_as_an_admin
    Given "I have signed in as an admin" do
      given_I_have_an_admin_password_credential
      when_sign_in_with_admin_data
      then_I_expect_to_be_signed_in_with_role('admin')
    end
  end

end
