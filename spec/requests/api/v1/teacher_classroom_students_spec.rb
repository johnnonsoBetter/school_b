require 'rails_helper'

RSpec.describe "Api::V1::TeacherClassroomStudents", type: :request do


  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      create :classroom, name: "js1", school: sch
      create :classroom, name: "js2", school: sch
      c3 = create :classroom, id: 3, name: "js3", school: sch

      stud1 = create :student, classroom: c3, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", middle_name: "paul", school: sch
      
      stud2 = create :student, classroom: c3, email: "chi2@gmail.com", password: "password", first_name: "muna", last_name: "p", middle_name: "obi", school: sch

      @teacher1 = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true, full_name: "teacher 1"
      @teacher2 = create :teacher, email: "t@mail.com", password: "password", school: sch, permitted: true, full_name: "teacher 2"
      @teacher3 = create :teacher, email: "teac@mail.com", password: "password", school: sch, permitted: false, full_name: "teacher 3"

      sub = create :subject, name: "maths", teacher: @teacher1, classroom: c3 
      sub2 = create :subject, name: "eng", teacher: @teacher2, classroom: c3

     

      @login_url = '/api/v1/teacher_auth/sign_in'
      @teacher_classroom_student_url = '/api/v1/teacher_classroom_students'
  
      @teacher1_params = {
        email: @teacher1.email,
        password: @teacher1.password
      }

      post @login_url, params: @teacher1_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

    end

    context "when teacher1 is not authenticated" do
      it "return http status unauthorized" do
        
        get @teacher_classroom_student_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when teacher1 is not permitted " do

      it "returns https status code 401 unauthorized" do
        @teacher1.permitted = false
        @teacher1.save 
        get @teacher_classroom_student_url, headers: @headers
        expect(response).to have_http_status(:unauthorized)  
      end
      
      
    end

    context "when teacher1 is authenticated " do

      subject {  get @teacher_classroom_student_url, headers: @headers, params: {classroom_id: 3}} 

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
end
