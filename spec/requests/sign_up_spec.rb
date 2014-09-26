require "spec_helper"

RSpec.describe "Sign Up", :type => :request do

  def json_response
    JSON(response.body)
  end

  describe "POST /sign_up.json" do

    describe "Error" do
      it "missing" do
        post "/hello/classic/sign_up.json"
        
        expect(response.status).to eq(400)
        expect(response.status_message).to eq("Bad Request")
        expect(json_response['exception']).to eq({
          "class"=>"ActionController::ParameterMissing",
          "message"=>"param is missing or the value is empty: sign_up"
        })        
      end

      it "blank" do
        sign_up_params = {email: ''}
        post "/hello/classic/sign_up.json", sign_up: sign_up_params

        expect(response.status).to eq(422)
        expect(response.status_message).to eq("Unprocessable Entity")
        expect(json_response).to eq({
          # "username"=>["is invalid", "minimum of 4 characters", "can't be blank"],
          "email"=>["can't be blank", "does not appear to be a valid e-mail address"],
          "password"=>["can't be blank", "minimum of 4 characters"],
          "name"=>["can't be blank"],
          "city"=>["can't be blank"]
        })
      end
    end

    it "Success" do
      sign_up_params = {email: "foo@bar.com", password: "foobar", name: "Foo Bar", city: "Brasilia", username: "foobar"}
      post "/hello/classic/sign_up.json", sign_up: sign_up_params

      expect(response.status).to eq(201)
      expect(response.status_message).to eq("Created")
      expect(json_response.keys).to match_array %w[access_token expires_at username email email_confirmed_at user user_id]
    end

  end
end
