require 'rails_helper'

RSpec.describe "Api::V1::AdminDashboards", type: :request do
  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      create :classroom, name: "js1", school: sch
      create :classroom, name: "js2", school: sch
      create :classroom, name: "js3", school: sch
      
      score_t1 = create :score_type, id: 1, name: "homework", school: sch
      score_t2 = create :score_type, id: 2, name: "exam", school: sch

      create :announcement_image, id: 3


      create :announcement, school: sch, announcement_image_id: 3, message: "Interhouse sport", expiration: Date.yesterday
      create :announcement, school: sch, announcement_image_id: 3, message: "Club Review", expiration: Date.today
      create :announcement, school: sch, announcement_image_id: 3, message: "Mid Term Break Approaching", expiration: Date.tomorrow
      create :announcement, school: sch, announcement_image_id: 3, message: "Exam Approching", expiration: Date.new(2021, 11, 12)
     

      @teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true, first_name: "teacher", middle_name: "k", last_name: "2"
      @teacher = create :teacher, email: "teacher1@mail.com", password: "password", school: sch, permitted: true, first_name: "teacher", middle_name: "k",last_name: "1"
 
     
      @login_url = '/api/v1/auth/sign_in'
      @admin_dashboard_url = '/api/v1/admin_dashboards'
  
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
        
        get @admin_dashboard_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  get @admin_dashboard_url, headers: @headers } 

      before do 

        subject
        @json_body = JSON.parse(response.body)

      end


      it "returns proper json first classroom response" do
        
        expect(@json_body['classrooms'].first).to include({
          "name" => "js1"
        })  
        
      end

      it "returns proper json last classroom response" do
       
        expect(@json_body['classrooms'].last).to include({
          "name" => "js3"
        })  
        
      end

      it "returns proper json first teacher response" do
        
        expect(@json_body['teachers'].first).to include({
          "full_name" => "teacher k 2"
        })  
        
      end

      it "returns proper json last teacher response" do
       
        expect(@json_body['teachers'].last).to include({
          "full_name" => "teacher k 1"
        })  
        
      end


      it "returns proper json first announcement response" do
       
        expect(@json_body['announcements'].first).to include({
          "message" => "Club Review"
        })  
        
      end

      it "returns proper json last announcement response" do
       
        expect(@json_body['announcements'].last).to include({
          "message" => "Exam Approching"
        })  
        
      end
      

      

      context "when admin is not permitted " do

        it "returns https status code 401 unauthorized" do
          @admin.permitted = false
          @admin.save 
          get @admin_dashboard_url
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end
      

     
 
    end
    

  end
end
