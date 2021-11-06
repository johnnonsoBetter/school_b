require 'rails_helper'

RSpec.describe "Api::V1::GuidanceDashboards", type: :request do


  describe "GET /index" do
    
    before do 
      sch = build :school, id: 44
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, classroom: class1, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
      stud2 = create :student, classroom: class1, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
      stud3 = create :student, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"
  
      @guidance = create :guidance, email: "mak3er@gmail.com", password: "password"
      @guidance2 = create :guidance, email: "shdfgdgfisf@gmail.com", password: "password"

      @guidance.students << stud1
      @guidance.students << stud3
      @guidance2.students << stud2

      create :announcement_image, id: 3
      create :announcement, school: sch, announcement_image_id: 3, message: "Interhouse sport"
      create :announcement, school: sch, announcement_image_id: 3, message: "Club Review"
      create :announcement, school: sch, announcement_image_id: 3, message: "Mid Term Break Approaching"
      create :announcement, school: sch, announcement_image_id: 3, message: "Exam Approching"
     
  


      @login_url = '/api/v1/guidance_auth/sign_in'
      @guidance_dashboard_url = '/api/v1/guidance_dashboards'
  
      @guidance_params = {
        email: @guidance.email,
        password: @guidance.password
      }

      
     
    end

    context "when guidance is not authenticated" do
      it "return http status unauthorized" do
        
        get @guidance_dashboard_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when guidance is authenticated " do
      
      before do 
        post @login_url, params: @guidance_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

        get @guidance_dashboard_url, headers: @headers
        @json_body = JSON.parse(response.body)
        
        
       
      end

      it "returns proper first json response" do
       
        expect(@json_body['students'].first).to include({
          'first_name' => 'chima',
          'last_name' => 'joy'
        })   
      end

      it "returns proper last json response" do
        expect(@json_body['students'].last).to include({
          'first_name' => 'praise',
          'last_name' => 'luna'
        })   
      end

      it "returns proper json first announcement response" do
       
        expect(@json_body['announcements'].first).to include({
          "message" => "Interhouse sport"
        })  
        
      end

      it "returns proper json last announcement response" do
       
        expect(@json_body['announcements'].last).to include({
          "message" => "Exam Approching"
        })  
        
      end
      
      
    end
    
    

  end
end
