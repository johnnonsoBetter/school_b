require 'rails_helper'

RSpec.describe "Api::V1::PublishDrafts", type: :request do
  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", middle_name: "paul", school: sch

      @teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true
      score_type = create :score_type, id: 1, name: "homework", school: sch
      sub =  create :subject, id: 1, name: "english", classroom: class1, teacher: @teacher
      sub2 =  create :subject, name: "maths", classroom: class1, teacher: @teacher

      create :score_report_draft, id: 1, max: 50, published: false, score_type: score_type, subject: sub, teacher: @teacher
      create :student_score_report_draft, id: 2,  student: stud1, score: 40, score_report_draft_id: 1
      

      @login_url = '/api/v1/teacher_auth/sign_in'
      @publish_drafts_url = '/api/v1/publish_drafts/'

      

     
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
        
        post @publish_drafts_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when teacher is authenticated " do

       subject {  post @publish_drafts_url, headers: @headers, params: {score_report_draft_id: 1} } 

      context "when student score report was succesfully created" do
        it "returns http status created" do
          
          subject
          expect(response).to have_http_status(:created) 
        end
        
        it "increment ScoreReport count from 0 to 1" do
          expect{subject}.to change{ScoreReport.count}.by(1)
        end

        it "changes the published attribute of the score_draft_report to true" do 

          subject
          expect(ScoreReportDraft.find(1).published).to eq(true)
          
        end
        
      end

      context "when score_report_draft has already been published" do
        it "returns http status :unprocessable entity" do
          ScoreReportDraft.find(1).update(published: true)
          subject
          expect(response).to have_http_status(:unprocessable_entity)
          
        end
        
      end
      

      context "when score draft report was not found" do
        it "returns http status not_found" do
          
          post @publish_drafts_url, headers: @headers, params: {score_report_draft_id: 4 }
          expect(response).to have_http_status(:not_found) 
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
