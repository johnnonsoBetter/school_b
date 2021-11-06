require 'rails_helper'

RSpec.describe "Api::V1::Attendances", type: :request do
  describe "PUT /update" do
   
    before do 
      sch = build :school, id: 44
      @class1 = create :classroom, name: "ss1", school: sch, class_teacher_id: 6
      stud1 = create :student, classroom: @class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", middle_name: "paul", school: sch

      @teacher = create :teacher, id: 6, email: "teacher@mail.com", password: "password", school: sch, permitted: true
      
      create :attendance, is_present: true, id: 1, classroom: @class1, student: stud1


      

      @login_url = '/api/v1/teacher_auth/sign_in'
      @attendance_url = '/api/v1/attendances/1'

      

     
      @teacher_params = {
        email: @teacher.email,
        password: @teacher.password
      }

      post @login_url, params: @teacher_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

    end

    context "when teacher is not authenticated" do
      it "return http status unauthorized" do
        
        put @attendance_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when teacher is authenticated " do

       subject {  put @attendance_url, headers: @headers, params: {attendance: {is_present: false}} } 

     
      context "when student score report was succesfully updated" do
        it "returns http status ok" do
          
          subject
          expect(response).to have_http_status(:ok) 
        end
        
      end

      context "when attendance could not be found " do

        it "returns http status ok" do
          
          put '/api/v1/attendances/13', headers: @headers, params: {attendance: {is_present: false}}
          
          expect(response).to have_http_status(:not_found) 
        end
        
      end

      context "when user trying to update the attendance is not a class teacher of that class" do

        subject {  put @attendance_url, headers: @headers, params: {attendance: {is_present: false}} } 

        it "returns http status unauthorized" do
          @class1.class_teacher_id = 7
          @class1.save
          subject
          expect(response).to have_http_status(:unauthorized) 
        end
        

      end

      context "when teacher is not permitted " do

        it "returns https status code 401 unauthorized" do
          @teacher.permitted = false
          @teacher.save 
          subject
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end


    end
    

  end
end
