require 'spec_helper'

RSpec.describe "Hello Gem", type: :controller do
  routes { Hello::Engine.routes }
  goal "Authentication" do
    capability "Request Can Carry an Access Token" do

      before do
        @token = given_I_have_a_classic_access_token.token
      end



      def self.via_session_feature
        ffeature "Via Session" do
          before(:each) do
            Given "a valid access token will be passed via session" do
              @request.session['token'] = @token
              @request.session['tokens'] = [@token]
            end
          end

          sstory "With a standard URL" do
            before(:each) do
              Given "the hostname is 'test.host'" do
                @request.host = "test.host"
              end
            end
            sscenario "As HTML" do
              When "I send a GET HTML request" do
                get :show, {format: :html}
              end

              Then "it should have a status 200 OK" do
                expect(response.status).to eq(200)
                expect(response.status_message).to eq("OK")
              end
            end

            sscenario "As JSON" do
              When "I send a GET JSON request" do
                get :show, {format: :json}
              end

              Then "it should have a status 200 OK" do
                expect(response.status).to eq(200)
                expect(response.status_message).to eq("OK")
              end
            end
          end

          sstory "With an API subdomain" do
            before(:each) do
              Given "the hostname is 'api.test.host'" do
                @request.host = "api.test.host"
              end
            end
            sscenario "As HTML" do
              When "I send a GET HTML request" do
                get :show, {format: :html}
              end

              Then "it should have a status 302 Found" do
                expect(response.status).to eq(302)
                expect(response.status_message).to eq("Found")
              end
            end

            sscenario "As JSON" do
              When "I send a GET JSON request" do
                get :show, {format: :json}
              end

              Then "it should have a status 401 Unauthorized" do
                expect(response.status).to eq(401)
                expect(response.status_message).to eq("Unauthorized")
              end
            end
          end
        end
      end



      def self.via_headers_feature
        ffeature "Via Session" do
          before(:each) do
            Given "a valid access token will be passed via headers" do
              @request.headers['HTTP_ACCESS_TOKEN'] = @token
            end
          end

          sstory "With a standard URL" do
            before(:each) do
              Given "the hostname is 'test.host'" do
                @request.host = "test.host"
              end
            end
            sscenario "As HTML" do
              When "I send a GET HTML request" do
                get :show, {format: :html}
              end

              Then "it should have a status 302 Found" do
                expect(response.status).to eq(302)
                expect(response.status_message).to eq("Found")
              end
            end

            sscenario "As JSON" do
              When "I send a GET JSON request" do
                get :show, {format: :json}
              end
              Then "it should have a status 401 Unauthorized" do
                expect(response.status).to eq(401)
                expect(response.status_message).to eq("Unauthorized")
              end
            end
          end

          sstory "With an API subdomain" do
            before(:each) do
              Given "the hostname is 'api.test.host'" do
                @request.host = "api.test.host"
              end
            end
            sscenario "As HTML" do
              When "I send a GET HTML request" do
                get :show, {format: :html}
              end

              Then "it should have a status 200 OK" do
                expect(response.status).to eq(200)
                expect(response.status_message).to eq("OK")
              end
            end

            sscenario "As JSON" do
              When "I send a GET JSON request" do
                get :show, {format: :json}
              end

              Then "it should have a status 200 OK" do
                expect(response.status).to eq(200)
                expect(response.status_message).to eq("OK")
              end
            end
          end
        end
      end



      def self.via_params_feature
        ffeature "Via Params" do
          before(:each) do
            Given "a valid access token will be passed via params" do
              # intentionally left blank
            end
          end

          sstory "With a standard URL" do
            before(:each) do
              Given "the hostname is 'test.host'" do
                @request.host = "test.host"
              end
            end
            sscenario "As HTML" do
              When "I send a GET HTML request" do
                get :show, {format: :html, access_token: @token}
              end

              Then "it should have a status 302 Found" do
                expect(response.status).to eq(302)
                expect(response.status_message).to eq("Found")
              end
            end

            sscenario "As JSON" do
              When "I send a GET JSON request" do
                get :show, {format: :json, access_token: @token}
              end
              Then "it should have a status 401 Unauthorized" do
                expect(response.status).to eq(401)
                expect(response.status_message).to eq("Unauthorized")
              end
            end
          end

          sstory "With an API subdomain" do
            before(:each) do
              Given "the hostname is 'api.test.host'" do
                @request.host = "api.test.host"
              end
            end
            sscenario "As HTML" do
              When "I send a GET HTML request" do
                get :show, {format: :html, access_token: @token}
              end

              Then "it should have a status 200 OK" do
                expect(response.status).to eq(200)
                expect(response.status_message).to eq("OK")
              end
            end

            sscenario "As JSON" do
              When "I send a GET JSON request" do
                get :show, {format: :json, access_token: @token}
              end

              Then "it should have a status 200 OK" do
                expect(response.status).to eq(200)
                expect(response.status_message).to eq("OK")
              end
            end
          end
        end
      end



      describe Hello::CurrentUsersController do
        via_session_feature

        via_headers_feature

        via_params_feature
      end

    end
  end

end

