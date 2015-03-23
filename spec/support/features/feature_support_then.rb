module Hello::FeatureSupportGiven

  def then_I_expect_to_be_signed_out
    Then "I expect to be signed out" do
      then_I_should_see "dummy-logged-out"
    end
  end

  def then_I_expect_to_be_signed_in
    Then "I expect to be signed in" do
      then_I_should_see "dummy-logged-in"
    end
  end

  def then_I_expect_to_be_signed_in_with_id(user_id)
    Then "I expect to be signed in as a specific user" do
      then_I_should_see "dummy-logged-in-User##{user_id}"
    end
  end

end
