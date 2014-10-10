require 'spec_helper'

describe "Classic" do
describe "Registration" do
describe "Reset Password" do

  def good_token_url
    return @good_token_url if @good_token_url
    #
    # SEND EMAIL
    #
    given_I_am_logged_in
    visit hello.root_path    
    expect_flash_info "foo@bar.com has not been confirmed yet. Send email confirmation now"

    #Hello::RegistrationMailer.should_receive(:confirm_email).and_return(double("mailer", deliver!: true))
    click_link "Send email confirmation now"
    expect_flash_notice "We have sent a confirmation email to foo@bar.com"
    expect_flash_info "A confirmation email has been sent to foo@bar.com less than a minute ago."

    #
    # EXTRACT URL
    #
    body = open_last_email.body.to_s
    href_value_regex = /href=\"(.*)"/
    matchdata = body.match(href_value_regex)
    @good_token_url = matchdata[1]
    expect(good_token_url).to start_with('http://')
    return @good_token_url
  end

  def visit_and_success(url)
    visit url

    expect(current_path).to eq hello.after_confirm_email_path
    expect_flash_notice "foo@bar.com has been confirmed successfully."
    expect_flash_info_blank
  end

  def visit_and_fail(url)
    visit url

    expect(current_path).to eq hello.confirm_email_expired_path
    expect_flash_alert "This link has expired, please ask for a new link"
  end

  describe "Success" do

    it "Email Confirmed" do
      visit_and_success good_token_url
    end

    it "Link Expired" do
      visit_and_success good_token_url
      visit_and_fail    good_token_url
    end
  end

  it "Alert - Link Expired" do
    visit_and_fail hello.confirm_email_token_path('wrong')
  end

end
end
end