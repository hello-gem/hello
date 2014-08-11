require 'spec_helper'

module Hello
module Classic
  describe RegistrationController do
    routes { Hello::Engine.routes }

    # POST /hello/classic/sign_up
    describe "POST sign_up" do
      describe "works" do

        it "Created" do
          params = {format: :json, sign_up: {email: "foo@bar.com", password: "foobar", name: "Foo Bar", city: "Brasilia"}}
          post :create, params
          
          json_body = JSON(response.body)
          expect(response.status).to eq(201)
          expect(response.status_message).to eq("Created")
          expect(json_body.keys).to match_array %w[token expires_at sudo_expires_at]
        end

      end
      
      describe "fails" do

        it "parameter missing" do
          post :create, {format: :json}
          
          json_body = JSON(response.body)
          expect(response.status).to eq(400)
          expect(response.status_message).to eq("Bad Request")
          expect(json_body['exception']).to eq({"class"=>"ActionController::ParameterMissing", "message"=>"param is missing or the value is empty: sign_up"})
        end

        it "blank data" do
          params = {format: :json, sign_up: {email: ""}}
          post :create, params
          
          json_body = JSON(response.body)
          expect(response.status).to eq(422)
          expect(response.status_message).to eq("Unprocessable Entity")
          expect(json_body).to eq({"errors"=>{"email"=>["can't be blank", "does not appear to be valid"], "password"=>["can't be blank", "minimum of 4 characters"]}})
        end

      end
    end

    # POST /hello/classic/sign_in
    describe "POST sign_in" do
      describe "works" do

        it "Created" do
          given_I_have_a_password_credential
          params = {format: :json, sign_in: {login: "foo@bar.com", password: "foobar"}}
          post :authenticate, params
          
          json_body = JSON(response.body)
          expect(response.status).to eq(201)
          expect(response.status_message).to eq("Created")
          expect(json_body.keys).to match_array %w[token expires_at sudo_expires_at]
        end

      end
      
      describe "fails" do

        it "parameter missing" do
          post :authenticate, {format: :json}
          
          json_body = JSON(response.body)
          expect(response.status).to eq(400)
          expect(response.status_message).to eq("Bad Request")
          expect(json_body['exception']).to eq({"class"=>"ActionController::ParameterMissing", "message"=>"param is missing or the value is empty: sign_in"})
        end

        it "blank data" do
          params = {format: :json, sign_in: {login: ""}}
          post :authenticate, params
          
          json_body = JSON(response.body)
          expect(response.status).to eq(422)
          expect(response.status_message).to eq("Unprocessable Entity")
          expect(json_body).to eq({"errors" => {"username"=>["was not found"]}})
        end

        it "username was not found" do
          params = {format: :json, sign_in: {login: "aaaa", password: ""}}
          post :authenticate, params
          
          json_body = JSON(response.body)
          expect(response.status).to eq(422)
          expect(response.status_message).to eq("Unprocessable Entity")
          expect(json_body).to eq({"errors" => {"username"=>["was not found"]}})
        end

        it "email was not found" do
          params = {format: :json, sign_in: {login: "aaaa@gmail.com", password: ""}}
          post :authenticate, params
          
          json_body = JSON(response.body)
          expect(response.status).to eq(422)
          expect(response.status_message).to eq("Unprocessable Entity")
          expect(json_body).to eq({"errors" => {"email"=>["was not found"]}})
        end

        it "password is incorrect" do
          given_I_have_a_password_credential
          params = {format: :json, sign_in: {login: "foo@bar.com", password: ""}}
          post :authenticate, params
          
          json_body = JSON(response.body)
          expect(response.status).to eq(422)
          expect(response.status_message).to eq("Unprocessable Entity")
          expect(json_body).to eq({"errors"=>{"password"=>["is incorrect"]}})
        end

      end
    end

  end
end
end
