require 'spec_helper'

describe "Classic" do
describe "Registration" do
describe "Sign In" do

  def get_last_access_token
    AccessToken.last
  end

  describe "Success" do
    before do
      given_I_have_a_classic_credential
    end

    it "Default" do
      when_sign_in_with_standard_data

      expect(current_path).to eq hello.after_sign_in_path
      expect(get_last_access_token.expires_at).to be > 29.minutes.from_now
    end

    it "Previous URL" do
      visit hello.user_path

      when_sign_in_with_standard_data

      expect(current_path).to eq hello.user_path
    end

    it "Keep Me" do
      visit hello.user_path

      when_sign_in_with_standard_data(keep_me: true)

      expect(get_last_access_token.expires_at).to be > 29.days.from_now
    end

    after do
      expect_flash_notice "You have signed in successfully"
      then_I_should_be_logged_in
    end
  end




  it "Error - Blank fields show validation errors" do
    when_sign_in_with_standard_data

    expect_error_message "1 error was found while trying to sign in"
    then_I_should_be_logged_out
  end




  it "Session Expiration" do
    given_I_have_a_classic_credential
    when_sign_in_with_standard_data
    then_I_should_be_logged_in

    #
    # First expectation
    #
    expect(get_last_access_token.expires_at).to be > 29.minutes.from_now
    expect(get_last_access_token.expires_at).to be < 31.minutes.from_now

    #
    # 25 minutes to expire, doesn't renew expiracy
    #
    get_last_access_token.update_attribute :expires_at, 25.minutes.from_now
    visit root_path
      then_I_should_be_logged_in
      expect(get_last_access_token.expires_at).to be < 26.minutes.from_now

    #
    # 19 minutes to expire, renews expiracy to 30 minutes
    #
    get_last_access_token.update_attribute :expires_at, 19.minutes.from_now
    visit root_path
      then_I_should_be_logged_in
      expect(get_last_access_token.expires_at).to be > 29.minutes.from_now

    #
    # 1 second after expire, expires your session
    #
    get_last_access_token.update_attribute :expires_at, 1.seconds.ago
    visit root_path
      then_I_should_be_logged_out
  end

end
end
end