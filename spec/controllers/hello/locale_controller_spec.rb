require 'spec_helper'

module Hello
  describe LocaleController do
    routes { Hello::Engine.routes }

    describe "Guest" do

      describe "GET 'index'" do
        describe "FORMATS" do
          it "HTML" do
            get :index
            expect(response_status).to eq([200, "OK"])
            expect(session.to_hash).to eq({"locale" => "en"})
          end

          it "JSON" do
            get :index, {format: :json}
            expect(response_status).to eq([200, "OK"])
            json_body = JSON(response.body)
            expect(json_body['locales'].keys).to eq(Hello.available_locales)
          end
        end
      end

      describe "POST 'update'" do
        describe "FORMATS" do
          it "HTML" do
            @request.headers['HTTP_REFERER'] = '/'
            post :update, {locale: 'pt-BR'}
            expect(response_status).to eq([302, "Found"])
            expect(session.to_hash).to eq({"locale"=>"pt-BR", "flash"=>{"discard"=>[], "flashes"=>{"notice"=>"Your current language has been applied successfully. 'Português (Brasil)'"}}})
          end

          it "JSON" do
            post :update, {format: :json, locale: 'pt-BR'}
            expect(response_status).to eq([400, "Bad Request"])
            json_body = JSON(response.body)
            expect(json_body).to eq({"exception"=>{"class"=>"Hello::JsonNotSupported", "message"=>"add your locale as a 'param' or 'header' instead"}})
          end
        end
      end

    end



  end
end
