require 'rails_helper'

RSpec.describe "Api::V1::Items", type: :request do
  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      @item_params = {item: {name: "js1 school book", selling_price: 500, quantity: 2}}

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








  describe "PUT /update" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      @item_params = {item: {name: "js1 school book", selling_price: 500, quantity: 3}}
      create :item, id: 1, name: "js1 school book", selling_price: 600, school: sch

      @login_url = '/api/v1/auth/sign_in'
      @item_url = '/api/v1/items/1'
  
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
        
        put @item_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  put @item_url, headers: @headers, params: @item_params } 

      context "when new item report has been updated" do
        it "increment item report by 1" do
          subject
          expect(Item.find(1).selling_price).to eq(500)
        end

        it "returns http status ok " do
          subject
          expect(response).to have_http_status(:ok)
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

      context "when item could not be found" do


        it "returns htpp status code unprocessable entity" do
          put '/api/v1/items/3', headers: @headers, params: @item_params
          expect(response).to have_http_status(:not_found)
          
        end

 
       end
      

      context "when new item failed to be updated" do


        it "returns htpp status code unprocessable entity" do
          put @item_url, headers: @headers, params: {item: {name: "", selling_price: 800}}
          expect(response).to have_http_status(:unprocessable_entity)
          
        end

 
       end

    end
    

  end


  describe "DELETE /destroy" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      @item_params = {item: {name: "js1 school book", selling_price: 500}}
      create :item, id: 1, name: "js1 school book", selling_price: 600, school: sch

      @login_url = '/api/v1/auth/sign_in'
      @item_url = '/api/v1/items/1'
  
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
        
        delete @item_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  delete @item_url, headers: @headers } 

      context "when item has been deleted" do
        it "increment item report by 1" do
          subject
          expect(Item.find_by(id: 1)).to eq(nil)
        end

        it "returns http status ok " do
          subject
          expect(response).to have_http_status(:no_content)
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
      

      context "when item could not be found" do


        it "returns htpp status code unprocessable entity" do
          delete '/api/v1/items/3', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end

 
       end

    end

    
    

  end


  describe "GET /show" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      @item_params = {item: {name: "js1 school book", selling_price: 500}}
      create :item, id: 1, name: "js1 school book", selling_price: 600, school: sch

      @login_url = '/api/v1/auth/sign_in'
      @item_url = '/api/v1/items/1'
  
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
        
        get @item_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  get @item_url, headers: @headers } 

      

      context "when admin is not permitted " do

        it "returns https status code 401 unauthorized" do
          @admin.permitted = false
          @admin.save 
          subject
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end


      context "when item has been deleted" do
        it "returns proper json response of item" do
          subject
          json_body = JSON.parse(response.body)
          
          expect(json_body['item']).to include({

            'name' => "js1 school book",
            'selling_price' => 600,

          })  
        end

     
        
      end
      

      context "when item could not be found" do


        it "returns htpp status code unprocessable entity" do
          get '/api/v1/items/3', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end

 
       end

    end

    
    

  end


  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      @item_params = {item: {name: "js1 school book", selling_price: 500}}
      create :item, name: "js1 school book", selling_price: 600, school: sch
      create :item, name: "js2 book", selling_price: 600, school: sch
      create :item, name: "ben carson", selling_price: 900, school: sch

      @login_url = '/api/v1/auth/sign_in'
      @item_url = '/api/v1/items/'
  
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
        
        get @item_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  get @item_url, headers: @headers } 

      

      context "when admin is not permitted " do

        it "returns https status code 401 unauthorized" do
          @admin.permitted = false
          @admin.save 
          subject
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end


      context "admin is authenticated and permitted" do
        it "returns proper json first response of items" do
          subject
          json_body = JSON.parse(response.body)
          
          expect(json_body.first).to include({

            'name' => "js1 school book",
            'selling_price' => 600,

          })  
        end

        it "returns proper json last response of items" do
          subject
          json_body = JSON.parse(response.body)
          
          expect(json_body.last).to include({

            'name' => "ben carson",
            'selling_price' => 900,

          })  
        end

     
        
      end
      

    end

    
    

  end


  


end

