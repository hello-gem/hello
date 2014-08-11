require 'spec_helper'

module Hello
  describe SignOutController do
    routes { Hello::Engine.routes }

    # POST /hello/sign_out
    describe "POST sign_up" do
      describe "works" do

        it "Destroyed" do
          delete :sign_out, {format: :json}
          
          expect(response.body).to eq('')
          expect(response.status).to eq(205)
          expect(response.status_message).to eq("Reset Content")
          expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
        end

      end
    end

  end
end
