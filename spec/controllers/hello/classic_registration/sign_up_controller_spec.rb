require 'rails_helper'

module Hello
  RSpec.describe ClassicRegistration::SignUpController, :type => :controller do

    describe "GET form" do
      it "returns http success" do
        get :form
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET create" do
      it "returns http success" do
        get :create
        expect(response).to have_http_status(:success)
      end
    end

  end
end
