require 'spec_helper'

RSpec.describe "Hello Gem", type: :request do
  goal_feature "Registration", "Onboarding Conclusion", "API" do



    before do
      mock_stateless!

      Given "I have a onboarding access token" do
        u = create(:onboarding)
        a = create(:access, user: u, expires_at: 24.hours.from_now)
        @token = a.token
        expect(User.last.role).to eq('onboarding')
      end
    end



    def _when_I_post(s, params={})
      When "I post #{s}" do
        params.merge!(access_token: @token)
        post "/onboarding.json", params
      end
    end



    sscenario "Valid Parameters" do
      _when_I_post "with accepting parameters", agree: 1

      then_I_should_get_a_response(200, 'OK')

      Then "and a user" do
        expect(json_response.keys).to include "user"
        expect(json_response['user']['role']).to eq "user"
      end

    end



    sscenario "Missing Parameters" do
      _when_I_post "with non-accepting parameters"

      then_I_should_get_a_response(422, 'Unprocessable Entity')

      Then "and a descriptive error" do
        expect(json_response).to eq("errors"=>"must agree to terms")
      end

      Then "and still be an onboarding" do
        expect(User.last.role).to eq('onboarding')
      end
    end



  end
end
