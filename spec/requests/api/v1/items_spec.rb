require 'rails_helper'

RSpec.describe "Api::V1::Items", type: :request do
  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      @item_params = {item: {name: "js1 school book", selling_price: 500}}

      @login_url = '/api/v1/auth/sign_in'
      @item_url = '/api/v1/items'
  
      @admin_params = {
        email: @admin.email,
        password: @admin.password
      }

      post @login_url, params: @admin_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

    end

    context "when admin is not authenticated" do
      it "return http status unauthorized" do
        
        post @item_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  post @item_url, headers: @headers, params: @item_params } 

      context "when new item report has been created" do
        it "increment item report by 1" do
          expect{subject}.to change{Item.count}.by(1)
        end

        it "returns http status created " do
          subject
          expect(response).to have_http_status(:created)
        end
        
      end

      context "when admin is not permitted " do

        it "returns https status code 401 unauthorized" do
          @admin.permitted = false
          @admin.save 
          subject
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end
      

      context "when new item failed to be created" do


        it "increment item report by 1" do
          expect{post @item_url, headers: @headers, params: {item: {name: "", selling_price: 79}}}.to_not change{Item.count}
        end

        it "returns htpp status code unprocessable entity" do
          post @item_url, headers: @headers, params: {item: {name: "", selling_price: 79}}
          expect(response).to have_http_status(:unprocessable_entity)
          
        end

 
       end

    end
    

  end
end
