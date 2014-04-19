


  def then_I_should_be_logged_in
    expect(page).to have_content "Hello, James Pinto!"
    expect(page).to have_content "Sign Out"
    expect(Hello::Session.count).to eq(1)
  end

  def then_I_should_be_logged_out
    expect(page).to have_content "Hello, Guest!"
    expect(Hello::Session.count).to eq(0)
  end





