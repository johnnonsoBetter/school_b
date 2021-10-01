require 'rails_helper'

RSpec.describe "Api::V1::StudentScoreReportDrafts", type: :request do
  
  describe "PUT /update" do
   
    before do 
      sch = build :school, id: 44
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", middle_name: "paul", school: sch

      @teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true
      score_type = create :score_type, id: 1, name: "homework", school: sch
      sub =  create :subject, id: 1, name: "english", classroom: class1, teacher: @teacher
      sub2 =  create :subject, name: "maths", classroom: class1, teacher: @teacher

      create :score_report_draft, id: 1, max: 50, published: true, score_type: score_type, subject: sub, teacher: @teacher
      create :student_score_report_draft, id: 1,  student: stud1, score: 40, score_report_draft_id: 1
      

      @login_url = '/api/v1/teacher_auth/sign_in'
      @student_score_report_drafts_url = '/api/v1/student_score_report_drafts/1'

      

     
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
        
        put @student_score_report_drafts_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when teacher is authenticated " do

       subject {  put @student_score_report_drafts_url, headers: @headers, params: {student_score_report_draft: {score: 14 }} } 

     
      context "when student score report was succesfully updated" do
        it "returns http status ok" do
          
          subject
          expect(response).to have_http_status(:ok) 
        end
        
      end

      context "when student score report was not succesfully updated" do
        it "returns http status unprocessable_entity" do
          
          put @student_score_report_drafts_url, headers: @headers, params: {student_score_report_draft: {score: nil }}
          expect(response).to have_http_status(:unprocessable_entity) 
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
