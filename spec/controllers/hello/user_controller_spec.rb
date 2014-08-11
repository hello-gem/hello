# require 'spec_helper'

# module Hello
#   describe UserController do

#     routes { Hello::Engine.routes }


#     # GET /hello/user

#     describe "GET edit" do

#       it "works" do
#         ss = given_I_have_a_classic_session

#         params = {format: :json, authentication_token: ss.token}
#         get :edit, params
        
#         json_body = JSON(response.body)
#         expect(response.status).to eq(201)
#         expect(response.status_message).to eq("Created")
#         expect(json_body.keys).to match_array %w[token expires_at sudo_expires_at]
#       end

#     end
    

#     # PATCH /hello/user
#     describe "PATCH update" do
#       describe "works" do

#         it "Ok" do
#           params = {format: :json, user: {}}
#           patch :update, params
          
#           json_body = JSON(response.body)
#           expect(response.status).to eq(201)
#           expect(response.status_message).to eq("Created")
#           expect(json_body.keys).to match_array %w[token expires_at sudo_expires_at]
#         end

#       end
      
#       describe "fails" do


#       end
#     end

#   end
# end
