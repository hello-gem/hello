


  def then_I_should_be_logged_in
    then_I_should_be_logged_in_as_a_user
  end

  def then_I_should_be_logged_in_as_a_user(expected_sessions_count=1)
    then_I_should_see "Hello, James Pinto!"
    then_I_should_see "Sign Out"
    expect(Session.count).to eq(expected_sessions_count)
  end

  def then_I_should_be_logged_in_as_an_admin
    then_I_should_see "Hello, Admin!"
    then_I_should_see "Sign Out"
    expect(Session.count).to eq(1)
  end

  def then_I_should_be_logged_out
    then_I_should_see "Hello, Guest!"
    expect(Session.count).to eq(0)
  end

  def then_I_should_see(text)
    expect(page).to have_content text
  end



