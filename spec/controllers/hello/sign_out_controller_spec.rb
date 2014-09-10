require 'spec_helper'

module Hello
  describe SignOutController do
    routes { Hello::Engine.routes }

    # POST /hello/sign_out
    describe "GET sign_out" do

      it "Signed Out" do
        get :sign_out, {format: :json}
      end

      it "Signed In" do
        s = given_I_have_a_classic_active_session
        expect(ActiveSession.count).to eq(1)
        get :sign_out, {format: :json, access_token: s.access_token}
      end

      after do
        expect(response.body).to eq('')
        expect(response.status).to eq(205)
        expect(response.status_message).to eq("Reset Content")
        expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
        expect(ActiveSession.count).to eq(0)
      end

    end

  end
end
