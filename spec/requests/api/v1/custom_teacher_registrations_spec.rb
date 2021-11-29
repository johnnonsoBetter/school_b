require 'rails_helper'

RSpec.describe "Api::V1::CustomStudentRegistrations", type: :request do
  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      c3 = create :classroom, id: 3, name: "js3", school: sch
      
      @student_params = {first_name: "john",
       last_name: "paul", 
       middle_name: "chisom", 
       classroom_id: 3, 
       date_of_birth: Date.today, 
       date_of_admission: Date.yesterday,
       address: "12 ogilble",
       state: "ebonyi",
       lga: "ohazara",
       religion: "christain",
       gender: "male",
       admission_no: "97989",
       image: "shfisshifsfh"

       
       }

      @login_url = '/api/v1/auth/sign_in'
      @student_url = '/api/v1/student_auth'
  
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
        
        post @student_url, params: @student_params
        
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  post @student_url, headers: @headers, params: @student_params } 

    #   context "when new student report has been created" do
    #     it "increment student report by 1" do
    #       expect{subject}.to change{Student.count}.by(1)
    #     end

    #     it "returns http status created " do
    #       subject
    #       expect(response).to have_http_status(:created)
    #     end
        
    #   end

      context "when admin is not permitted " do

        it "returns https status code 401 unauthorized" do
          @admin.permitted = false
          @admin.save 
          subject
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end
      

      # context "when new student failed to be created" do


      #   it "increment student report by 1" do
      #     expect{post @student_url, headers: @headers, params: {student: {full_name: ""}}}.to_not change{student.count}
      #   end

      #   it "returns htpp status code unprocessable entity" do
      #     post @student_url, headers: @headers, params: {student: {full_name: ""}}
      #     expect(response).to have_http_status(:unprocessable_entity)
          
      #   end

      # end
 
    end
    

  end

end
