require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do
  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      create :classroom, name: "js1", school: sch
      create :classroom, name: "js2", school: sch
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
  
      c3 = create :classroom, id: 3, name: "js3", school: sch

      stud1 = create :student, classroom: c3, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", middle_name: "paul", school: sch
      
      stud2 = create :student, classroom: c3, email: "chi2@gmail.com", password: "password", first_name: "muna", last_name: "p", middle_name: "obi", school: sch


      @login_url = '/api/v1/auth/sign_in'
      @student_url = '/api/v1/students'
  
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
        
        get @student_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is not permitted " do

      it "returns https status code 401 unauthorized" do
        @admin.permitted = false
        @admin.save 
        get @student_url, headers: @headers
        expect(response).to have_http_status(:unauthorized)  
      end
      
      
    end

    context "when admin is authenticated " do

      subject {  get @student_url, headers: @headers} 

      before do 
        subject

        @json_body = JSON.parse(response.body)
        

      end


      it "returns proper json response of the first students of class" do
        expect(@json_body.first).to include({
          'full_name' => 'chima paul joy'
        })  
        
      end
      it "returns proper json response of the last students of class" do
        expect(@json_body.last).to include({
          'full_name' => 'muna obi p'
        })  
        
      end
      


      
 
    end
    

  end


  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      create :classroom, name: "js1", school: sch
      create :classroom, name: "js2", school: sch
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
  
      c3 = create :classroom, id: 3, name: "js3", school: sch

      stud1 = create :student, classroom: c3, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", middle_name: "paul", school: sch
      
      

      @login_url = '/api/v1/auth/sign_in'
      @student_url = '/api/v1/students/34'
  
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
        
        get @student_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is not permitted " do

      it "returns https status code 401 unauthorized" do
        @admin.permitted = false
        @admin.save 
        get @student_url, headers: @headers
        expect(response).to have_http_status(:unauthorized)  
      end
      
      
    end


    context "when student could not be found " do 

      it "returns have_http_status :not_found" do 
        get '/api/v1/students/334', headers: @headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when admin is authenticated " do

      subject {  get @student_url, headers: @headers} 

      before do 
        subject

        @json_body = JSON.parse(response.body)
        

      end


      it "returns proper json response of student" do
        
        expect(@json_body['student']).to include({
          'full_name' => 'chima paul joy'
        })  
        
      end

     it "returns http status" do 
        expect(@json_body['student']).to include({
          'classroom' => 'js3'
        }) 

     end

    end

  end
end
