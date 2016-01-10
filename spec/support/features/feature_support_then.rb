module Hello::FeatureSupportGiven
  def then_I_expect_to_be_signed_out
    Then 'I should be signed out' do
      then_I_should_see 'dummy-logged-out'
    end
  end

  def then_I_expect_to_be_signed_in
    Then 'I should be signed in' do
      then_I_should_see 'dummy-logged-in'
    end
  end

  def then_I_expect_to_be_signed_in_with_role(role = 'user')
    Then "I should be signed in as a #{role.capitalize}" do
      then_I_should_see "dummy-logged-in-role-#{role}"
    end
  end

  def then_I_expect_to_be_signed_in_with_id(user_id)
    Then 'I should be signed in as a specific user' do
      then_I_should_see "dummy-logged-in-User##{user_id}"
    end
  end

  def then_I_expect_to_be_signed_in_with_sudo_mode
    Then 'I should be signed in with Sudo Mode' do
      then_I_should_see 'dummy-logged-in-with-sudo-mode'
    end
  end

  def then_I_expect_to_be_on_sudo_mode
    Then 'I should be on Sudo Mode' do
      then_I_should_see 'dummy-logged-in-with-sudo-mode'
    end
  end

  def then_I_expect_not_to_be_on_sudo_mode
    Then 'I should not be on Sudo Mode' do
      then_I_should_see 'dummy-logged-in-without-sudo-mode'
    end
  end
end
