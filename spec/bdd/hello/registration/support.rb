
def fill_in_registration_form
  within("form#new_sign_up") do
    fill_in 'sign_up_name',     with: 'James Pinto'
    fill_in 'sign_up_email',    with: 'foo@bar.com'
    fill_in 'sign_up_username', with: 'foobar'
    fill_in 'sign_up_password', with: '1234'
    fill_in 'sign_up_city',     with: 'OMG! I can customize Hello!'
  end
end
