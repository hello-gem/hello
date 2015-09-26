require 'spec_helper'

RSpec.describe "Hello Gem", type: :request do
  goal_feature "Registration", "Email Sign Up", "API" do



    def _when_I_post(s, params={})
      When "I post #{s}" do
        post "/hello/sign_up.json", params
      end
    end



    sscenario "Valid Parameters" do
      _when_I_post "valid parameters", sign_up: {email: "foo@bar.com", password: "foobar", name: "Foo Bar", city: "Brasilia", username: "foobar"}

      then_I_should_get_a_response(201, 'Created')

      Then "and a token" do
        expect(json_response.keys).to include "token"
      end

      Then "and an expiration time" do
        expect(json_response.keys).to include "expires_at"
      end

      Then "and an onboarding user" do
        expect(json_response.keys).to include "user_id"
        expect(json_response.keys).to include "user"
        expect(json_response['user']['role']).to eq "onboarding"
      end
    end



    sscenario "Missing Parameters" do
      _when_I_post "no parameters"

      then_I_should_get_a_response(400, 'Bad Request')

      Then "and a descriptive exception" do
        expect(json_response['exception']).to eq({
          "class"=>"ActionController::ParameterMissing",
          "message"=>"param is missing or the value is empty: sign_up"
        })
      end

      Then "and should not have signed up" do
        expect(User.count).to eq(0)
      end
    end



    sscenario "Blank Parameters" do
      _when_I_post "blank parameters", sign_up: {email: ''}

      then_I_should_get_a_response(422, 'Unprocessable Entity')

      Then "and validation errors" do
        expect(json_response).to eq({
          # "username"=>["is invalid", "minimum of 4 characters", "can't be blank"],
          "email"=>["can't be blank", "does not appear to be a valid e-mail address"],
          "password"=>["can't be blank", "minimum of 4 characters"],
          "name"=>["can't be blank"],
          "city"=>["can't be blank"]
        })
      end

      Then "and should not have signed up" do
        expect(User.count).to eq(0)
      end
    end




  end
end
