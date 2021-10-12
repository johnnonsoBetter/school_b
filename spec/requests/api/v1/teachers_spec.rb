require 'rails_helper'

RSpec.describe "Api::V1::Teachers", type: :request do
  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true


      stud1 = create :teacher, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", middle_name: "paul", school: sch
      
      stud2 = create :teacher, email: "chi2@gmail.com", password: "password", first_name: "muna", last_name: "p", middle_name: "obi", school: sch


      @login_url = '/api/v1/auth/sign_in'
      @teacher_url = '/api/v1/teachers'
  
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
        
        get @teacher_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is not permitted " do

      it "returns https status code 401 unauthorized" do
        @admin.permitted = false
        @admin.save 
        get @teacher_url, headers: @headers
        expect(response).to have_http_status(:unauthorized)  
      end
      
      
    end

    context "when admin is authenticated " do

      subject {  get @teacher_url, headers: @headers} 

      before do 
        subject

        @json_body = JSON.parse(response.body)
        

      end


      it "returns proper json response of the first teachers of class" do
        expect(@json_body.first).to include({
          'full_name' => 'chima paul joy'
        })  
        
      end
      it "returns proper json response of the last teachers of class" do
        expect(@json_body.last).to include({
          'full_name' => 'muna obi p'
        })  
        
      end
      


      
 
    end
    

  end
end
