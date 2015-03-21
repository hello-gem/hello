require "spec_helper"

RSpec.describe "Security", :type => :request do

  context "PATCH /user.json" do

    let(:auth_headers) { {'HTTP_ACCESS_TOKEN' => given_I_have_a_classic_access_token.access_token} }

    it "Role" do
      user_params = {user: {role: "admin"}}
      auth_headers # touch
      expect {
        patch "/hello/user.json", user_params, auth_headers

        expect(response.status).to eq(200)
      }.not_to change { User.last.role }.from('user')
    end

    it "PasswordDigest" do
      user_params = {user: {password_digest: "new"}}
      auth_headers # touch
      expect {
        patch "/hello/user.json", user_params, auth_headers

        expect(response.status).to eq(200)
      }.not_to change { User.last.password_digest }
    end

    it "PasswordTokenDigest" do
      user_params = {user: {password_token_digest: "new"}}
      auth_headers # touch
      expect {
        patch "/hello/user.json", user_params, auth_headers

        expect(response.status).to eq(200)
      }.not_to change { User.last.password_token_digest }
    end

    it "PasswordTokenDigestedAt" do
      user_params = {user: {password_token_digested_at: Time.now}}
      auth_headers # touch
      expect {
        patch "/hello/user.json", user_params, auth_headers

        expect(response.status).to eq(200)
      }.not_to change { User.last.password_token_digested_at }
    end

  end
end
