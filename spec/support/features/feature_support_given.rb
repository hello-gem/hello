module Hello::FeatureSupportGiven

  def given_I_have_not_signed_in
    Given("I have not signed in") {  }
  end

  def given_I_have_signed_in
    Given "I have signed in" do
      given_I_am_logged_in
    end
  end

  def given_I_have_signed_in_with_sudo_mode
    Given "I have signed in with sudo mode" do
      given_I_am_logged_in
      visit "/hello/emails"
      when_I_confirm_sudo_mode
    end
  end

end
