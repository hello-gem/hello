


  def then_I_should_be_logged_in
    then_I_should_be_logged_in_as_a_user
  end

  def then_I_should_be_logged_in_as_a_user(expected_accesses_count=1)
    then_I_should_see "Hello, James Pinto!"
    then_I_should_see "Sign Out"
    expect(Access.count).to eq(expected_accesses_count)
  end

  def then_I_should_be_logged_in_as_a_webmaster
    then_I_should_see "Hello, Admin!"
    then_I_should_see "Sign Out"
    expect(Access.count).to eq(1)
  end

  def then_I_should_be_logged_out(expected_accesses_count=0)
    then_I_should_see "Hello, Guest!"
    # expect(Access.count).to eq(expected_accesses_count)
  end

  def then_I_should_see(text)
    expect(page).to have_content text
  end

  def then_I_should_not_see(text)
    expect(page).not_to have_content text
  end
