require 'rails_helper'

RSpec.describe "Api::V1::Announcements", type: :request do


  describe "POST /create" do

    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      
      @announcement_params = {announcement: {message: "Mid Term Break Is Fast approaching by 12th august 2021", announcement_image_id: 3, expiration: Date.today} }
      create :announcement_image, id: 3
     
      @login_url = '/api/v1/auth/sign_in'
      @announcement_url = '/api/v1/announcements'
  
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
        
        post @announcement_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end
  
    context "when admin is authenticated " do
  
      subject {  post @announcement_url, headers: @headers, params: @announcement_params } 
  
      context "when new announcement  has been created" do
        it "increment announcement  by 1" do
          expect{subject}.to change{Announcement.count}.by(1)
        end
        
  
        it "returns http status created " do
          subject
          expect(response).to have_http_status(:created)
        end
        
      end
  
  
  
       context "when new announcement failed to be created" do
  
        it "does not increment announcement  by 1" do
          expect{
  
            post @announcement_url, headers: @headers, params: {announcement: {message: "Mid Term Break Is Fast approaching by 12th august 2021", announcement_image_id: 3, expiration: ""} }
  
          }.not_to change{Announcement.count}
        end
  
        it "returns htpp status code unprocessable entity" do
          post @announcement_url, headers: @headers, params: {announcement: {message: "Mid Term Break Is Fast approaching by 12th august 2021", announcement_image_id: 3, expiration: ""} }
          expect(response).to have_http_status(:unprocessable_entity)
          
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
      
  
    
  
    end
    
  end



  describe "PUT /update" do

    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      
      @announcement_params = {announcement: {message: "Mid Term Break Is Fast approaching by 12th august 2021", announcement_image_id: 3, expiration: Date.today} }
      
      create :announcement_image, id: 3
      create :announcement, id: 7, school: sch, announcement_image_id: 3, message: "Mid Term Break Approaching", expiration: Date.tomorrow
     
      @login_url = '/api/v1/auth/sign_in'
      @announcement_url = '/api/v1/announcements/7'
  
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
        
        put @announcement_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end
  
    context "when admin is authenticated " do
  
      subject {  put @announcement_url, headers: @headers, params: @announcement_params } 
  
      context "when announcement  has been updated" do
        
  
        it "returns http status ok " do
          subject
          expect(response).to have_http_status(:ok)
        end
        
      end
  
  
  
       context "when announcement failed to be updated" do
  
        it "returns htpp status code unprocessable entity" do
          put @announcement_url, headers: @headers, params: {announcement: {message: "", announcement_image_id: 3, expiration: ""} }
          expect(response).to have_http_status(:unprocessable_entity)
          
        end
  
      end


      context "when announcement could not be found" do
  
        it "returns htpp status code unprocessable entity" do
          put '/api/v1/announcements/4', headers: @headers, params: {announcement: {message: "", announcement_image_id: 3, expiration: ""} }
          expect(response).to have_http_status(:not_found)
          
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
      
  
    
  
    end
    
  end



  describe "GET /index" do

    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      
      create :announcement_image, id: 3
      create :announcement, id: 7, school: sch, announcement_image_id: 3, message: "Mid Term Break Approaching", expiration: Date.tomorrow
      create :announcement, school: sch, announcement_image_id: 3, message: "Exam Approching", expiration: Date.tomorrow
     
      @login_url = '/api/v1/auth/sign_in'
      @announcement_url = '/api/v1/announcements'
  
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
        
        get @announcement_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end
  
    context "when admin is authenticated " do
  
      subject {  get @announcement_url, headers: @headers, params: @announcement_params } 
  
   
        it "returns proper first json response of announcement list " do
          subject
          json_body = JSON.parse(response.body)
          expect(json_body.first).to include({
            'message' => 'Mid Term Break Approaching',

          })
        end

        it "returns proper last json response of announcement list " do
          subject
          json_body = JSON.parse(response.body)
          expect(json_body.last).to include({
            'message' => 'Exam Approching',
            
          })
        end
    
  
      context "when admin is not permitted " do
  
        it "returns https status code 401 unauthorized" do
          @admin.permitted = false
          @admin.save 
          subject
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end
      
  
    
  
    end
    
  end
 
end
