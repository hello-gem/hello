require "spec_helper"

RSpec.describe "Forgot Password", :type => :request do

  describe "POST /password/forgot.json" do

    describe "Error" do
      it "missing" do
        post "/hello/password/forgot.json"
        
        expect(response.status).to eq(400)
        expect(response.status_message).to eq("Bad Request")
        expect(json_response['exception']).to eq({
          "class"=>"ActionController::ParameterMissing",
          "message"=>"param is missing or the value is empty: forgot_password"
        })        
      end

      it "blank" do
        forgot_password_params = {login: ''}
        post "/hello/password/forgot.json", forgot_password: forgot_password_params

        expect(response.status).to eq(422)
        expect(response.status_message).to eq("Unprocessable Entity")
        expect(json_response).to eq({
          "login"=>["was not found"],
        })
      end
    end

    it "Success" do
      given_I_have_an_email_credential

      forgot_password_params = {login: "foobar", password: "1234"}
      post "/hello/password/forgot.json", forgot_password: forgot_password_params

      expect(response.status).to eq(201)
      expect(response.status_message).to eq("Created")
      expect(json_response.keys).to match_array %w[sent]
    end

  end
end
