
  def expect_flash_notice(text)
    expect(page).to have_selector ".alert-success", text: text
  end

  def expect_flash_alert(text)
    expect(page).to have_selector ".alert-warning", text: text
  end

  def expect_error_message(text)
    expect(page).to have_selector "form h2.errors", text: text
  end


  def expect_flash_notice_signed_in
    expect_flash_notice "You have signed in successfully"
  end





