require 'rails_helper'

RSpec.describe "Api::V1::AnnouncementImages", type: :request do
  describe "GET /index" do

    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      
      create :announcement_image, id: 3, image: "hisfhsfisjfsdf"
      create :announcement_image, id: 33, image: "sfsrevsfvs"
      create :announcement_image, id: 32, image: "sfsehrytrgrgreter"
      
      @login_url = '/api/v1/auth/sign_in'
      @announcement_url = '/api/v1/announcement_images'
  
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
            'image' => 'hisfhsfisjfsdf',

          })
        end

        it "returns proper last json response of announcement list " do
          subject
          json_body = JSON.parse(response.body)
          expect(json_body.last).to include({
            'image' => 'sfsehrytrgrgreter',
            
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
