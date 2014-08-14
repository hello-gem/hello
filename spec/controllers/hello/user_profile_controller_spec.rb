require 'spec_helper'

module Hello
  describe UserProfileController do

    routes { Hello::Engine.routes }

    before do
      s = given_I_have_a_classic_session
      @request.headers['access_token'] = s.access_token
    end

    # GET /hello/user
    describe "GET edit" do

      it "works" do
        params = {format: :json}
        get :edit, params
        
        json_body = JSON(response.body)
        expect(response.status).to eq(200)
        expect(response.status_message).to eq("OK")
        expect(json_body.keys).to include *%w[id name role language time_zone created_at updated_at]
      end

    end
    
    # PATCH /hello/user
    describe "PATCH update" do
      it "works" do
        params = {format: :json, user: {name: "James"}}
        patch :update, params
        
        json_body = JSON(response.body)
        expect(response.status).to eq(200)
        expect(response.status_message).to eq("OK")
        expect(json_body.keys).to include *%w[id name role language time_zone created_at updated_at]
      end

      describe "fails" do

        it "parameter missing" do
          params = {format: :json}
          post :update, params

          json_body = JSON(response.body)
          expect(response.status).to eq(400)
          expect(response.status_message).to eq("Bad Request")
          expect(json_body['exception']).to eq({"class"=>"ActionController::ParameterMissing", "message"=>"param is missing or the value is empty: user"})
        end

        it "blank data" do
          params = {format: :json, user: {name: ""}}
          patch :update, params
          
          json_body = JSON(response.body)
          expect(response.status).to eq(422)
          expect(response.status_message).to eq("Unprocessable Entity")
          expect(json_body).to eq({"name"=>["can't be blank"]})
        end

      end
    end

  end
end
