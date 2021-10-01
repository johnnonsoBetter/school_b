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
       
        expect(@json_body.first).to include({
          'first_name' => 'chima',
          'last_name' => 'joy'
        })   
      end

      it "returns proper last json response" do
        expect(@json_body.last).to include({
          'first_name' => 'praise',
          'last_name' => 'luna'
        })   
      end
      
      
    end
    
    

  end
end
