require 'spec_helper'

describe "Classic" do
describe "Registration" do
describe "Confirm Email" do

  # TODO: MOVE THIS FILE, THIS SHOULD NOW BE CONSIDERED A CREDENTIAL FEATURE


  describe "Success" do

    it "Email Confirmed" do
      visit_and_success good_token_url
    end

    it "Link Expired" do
      visit_and_success good_token_url
      visit_and_fail    good_token_url
    end
  end

  describe "Alert" do

    it "Link Expired" do
      visit_and_fail expired_token_url

      visit_the_main_page
      expect_to_see "has not been confirmed yet."
    end

    it "Link Invalid" do
      visit invalid_token_url

      expect(current_path).to eq hello.sign_in_path
      expect_flash_alert "You must sign in to continue."

      given_I_have_a_classic_credential
      when_sign_in_with_standard_data

      expect(current_path).to eq hello.confirm_credential_path(current_credential)
    end

  end






  private

  def visit_and_success(url)
    visit url
    __fetch_current_active_session

    expect(current_path).to eq hello.confirm_done_credential_path(current_credential)
    expect_flash_notice "foo@bar.com has been confirmed successfully"
    
    visit_the_main_page
    expect_to_see "was confirmed less than a minute ago."
  end

  def visit_and_fail(url)
    visit url

    expect(current_path).to eq hello.confirm_expired_credential_path(safe_current_credential)
    expect_flash_alert "This link has expired, please ask for a new link"
  end


  def good_token_url
    return @good_token_url if @good_token_url
    given_I_am_logged_in
    _deliver_email
    when_I_sign_out

    @good_token_url = _extracted_url_from_email
  end

  def invalid_token_url
    hello.confirm_token_credential_path(1, 'wrong')
  end

  def expired_token_url
    return @expired_token_url if @expired_token_url

    given_I_am_logged_in

    current_credential.update! email_token_digested_at: 1.year.ago

    @expired_token_url = hello.confirm_token_credential_path(current_credential, 'wrong')
  end

  def safe_current_credential
    current_credential
  rescue
    0
  end





  def _deliver_email
    visit_the_main_page
    expect_to_see "has not been confirmed yet."
    
    click_button "Request Confirmation Email"
    
    expect_flash_notice "We have sent a confirmation email to foo@bar.com"
    expect_to_see "A confirmation email was sent to foo@bar.com less than a minute ago."
  end

  def _extracted_url_from_email
    body = open_last_email.body.to_s
    href_value_regex = /href=\"(.*)"/
    matchdata = body.match(href_value_regex)
    string = matchdata[1]
    expect(string).to start_with('http://')
    string
  end

  def visit_the_main_page
    visit hello.confirm_credential_path(current_credential)
  end



end
end
end