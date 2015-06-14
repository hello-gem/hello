require 'spec_helper'

module Hello

describe "Authentication" do
  routes { Hello::Engine.routes }

  # As anyone
  # I can visit various URLs
  # So I have differenct access and restrictions

  describe "Not Authenticated" do

    describe CurrentUserController do

      it "HTML" do
        get :edit
        expect(response.status).to eq(302)
        expect(response.status_message).to eq("Found")
        
        expect(session.keys).to match_array ["flash", "locale", "url"]
        expect(session['locale']).to eq "en"
        expect(session['url']).to    eq "/hello/user"
        expect(flash[:alert]).to     eq "You must sign in to continue."

        # expect(session.to_hash).to eq({"locale" => "en", "url"=>"/hello/user", "flash"=>{"discard"=>[], "flashes"=>{:alert=>"You must sign in to continue."}}})

        expect(response).to redirect_to('/hello/homepage')
      end

      it "JSON" do
        get :edit, {format: :json}
        json_body = JSON(response.body)
        expect(response.status).to eq(401)
        expect(response.status_message).to eq("Unauthorized")
        expect(json_body['exception']).to eq({"class"=>"Hello::NotAuthenticated", "message"=>"An active access token must be used to query information about the current user."})
      end

    end

  end

  describe "Authenticated" do

    describe CurrentUserController do

      before { @s = given_I_have_a_classic_access_token }

      it "PARAMS" do
        get :edit, {format: :json, access_token: @s.access_token}
        json_body = JSON(response.body)
        expect(response.status).to eq(200)
        expect(response.status_message).to eq("OK")
        expect(json_body.keys).to match_array(["id", "created_at", "updated_at", "name", "role", "username", "locale", "time_zone", "credentials_count", "access_tokens_count", "city"])
      end

      it "SESSION" do
        @request.session['access_token'] = @s.access_token
        get :edit, {format: :json}#, {access_token: @s.access_token}
        json_body = JSON(response.body)
        expect(response.status).to eq(200)
        expect(response.status_message).to eq("OK")
        expect(json_body.keys).to match_array(["id", "created_at", "updated_at", "name", "role", "username", "locale", "time_zone", "credentials_count", "access_tokens_count", "city"])
      end

      it "COOKIE" do
        @request.cookies['access_token'] = @s.access_token
        get :edit, {format: :json}
        json_body = JSON(response.body)
        expect(response.status).to eq(200)
        expect(response.status_message).to eq("OK")
        expect(json_body.keys).to match_array(["id", "created_at", "updated_at", "name", "role", "username", "locale", "time_zone", "credentials_count", "access_tokens_count", "city"])
      end

      it "HEADER" do
        @request.headers['HTTP_ACCESS_TOKEN'] = @s.access_token
        get :edit, {format: :json}
        json_body = JSON(response.body)
        expect(response.status).to eq(200)
        expect(response.status_message).to eq("OK")
        expect(json_body.keys).to match_array(["id", "created_at", "updated_at", "name", "role", "username", "locale", "time_zone", "credentials_count", "access_tokens_count", "city"])
      end

    end
  end

  describe "Others" do
    describe CurrentUserController do

      it "Access Token Expired" do
        @s = given_I_have_a_classic_access_token
        @s.update! expires_at: 1.second.ago

        get :edit, {format: :json, access_token: @s.access_token}
        json_body = JSON(response.body)
        expect(response.status).to eq(401)
        expect(response.status_message).to eq("Unauthorized")
        expect(json_body['exception']).to eq({"class"=>"Hello::NotAuthenticated", "message"=>"An active access token must be used to query information about the current user."})
      end

      it "Sudo Mode Required" do
        skip "important, but not urgent"
      end

      it "Sudo Mode Expired" do
        skip "important, but not urgent"
      end

    end
  end

end
end



