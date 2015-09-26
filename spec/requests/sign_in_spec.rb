require "spec_helper"

RSpec.describe "Sign In", :type => :request do

  describe "POST /sign_in.json" do

    describe "Error" do
      it "missing" do
        post "/hello/sign_in.json"
        
        expect(response.status).to eq(400)
        expect(response.status_message).to eq("Bad Request")
        expect(json_response['exception']).to eq({
          "class"=>"ActionController::ParameterMissing",
          "message"=>"param is missing or the value is empty: sign_in"
        })        
      end

      it "blank" do
        sign_in_params = {login: ''}
        post "/hello/sign_in.json", sign_in: sign_in_params

        expect(response.status).to eq(422)
        expect(response.status_message).to eq("Unprocessable Entity")
        expect(json_response).to eq({
          "login"=>["was not found"],
        })
      end
    end

    it "Success" do
      given_I_have_an_email_credential

      sign_in_params = {login: "foobar", password: "foobar"}
      post "/hello/sign_in.json", sign_in: sign_in_params

      expect(response.status).to eq(201)
      expect(response.status_message).to eq("Created")
      expect(json_response.keys).to match_array %w[token expires_at user user_id]
    end

  end
end
