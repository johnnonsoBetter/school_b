require 'rails_helper'

RSpec.describe "Api::V1::VapidKeys", type: :request do
  describe "POST" do
   
    

   
    context "when new webpush notifications has been created " do 

       it "increment web_push_notification by 1" do
          get '/api/v1/vapid_keys' 
          # json_body = JSON.parse(response.body)\

          # expect(json_body).to include(Rails.application.credentials.dig(:webpush, :public_key))
        end

    end

     
  end
end
