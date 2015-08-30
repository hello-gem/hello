require 'spec_helper'

RSpec.describe "Hello Gem", type: :request do
  goal_feature "Registration", "Novice Conclusion", "API" do



    before do
      allow_any_instance_of(ActionController::Base).to receive(:is_request_stateless?).and_return(true)

      Given "I have a novice access token" do
        u = create(:novice)
        at = create(:access_token, user: u, expires_at: 24.hours.from_now)
        @token = at.access_token
        expect(User.last.role).to eq('novice')
      end
    end



    def _when_I_post(s, params={})
      When "I post #{s}" do
        params.merge!(access_token: @token)
        post "/novice.json", params
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

      Then "and still be a novice" do
        expect(User.last.role).to eq('novice')
      end
    end



  end
end
