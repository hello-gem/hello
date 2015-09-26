require 'spec_helper'

RSpec.describe "Hello Gem", type: :request do
  goal_feature "Authentication", "Email Sign In", "API" do



    def _when_I_post(s, params={})
      When "I post #{s}" do
        post "/hello/sign_in.json", params
      end
    end



    before do
      given_I_have_an_email_credential
    end



    sscenario "Valid Parameters" do
      _when_I_post "valid parameters", sign_in: {login: "foo@bar.com", password: "foobar"}

      then_I_should_get_a_response(201, 'Created')

      Then "and a token" do
        expect(json_response.keys).to include "token"
      end

      Then "and an expiration time" do
        expect(json_response.keys).to include "expires_at"
      end

      Then "and a user" do
        expect(json_response.keys).to include "user_id"
        expect(json_response.keys).to include "user"
      end
    end

    def _and_I_should_not_have_signed_in
      Then "and should not have signed in" do
        expect(Access.count).to eq(0)
      end
    end



    sscenario "Missing Parameters" do
      _when_I_post "no parameters"

      then_I_should_get_a_response(400, 'Bad Request')

      Then "and a descriptive exception" do
        expect(json_response['exception']).to eq({
          "class"=>"ActionController::ParameterMissing",
          "message"=>"param is missing or the value is empty: sign_in"
        })
      end

      _and_I_should_not_have_signed_in
    end



    sscenario "Blank Parameters" do
      _when_I_post "blank parameters", sign_in: {login: ''}

      then_I_should_get_a_response(422, 'Unprocessable Entity')

      Then "and validation errors" do
        expect(json_response).to eq({
          "login"=>["was not found"]
        })
      end

      _and_I_should_not_have_signed_in
    end




  end
end
