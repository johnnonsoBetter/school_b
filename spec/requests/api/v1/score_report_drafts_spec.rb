require 'rails_helper'

RSpec.describe "Api::V1::ScoreReportDrafts", type: :request do
  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
      create :student, classroom: class1, email: "cammy@gmail.com", password: "password", first_name: "julio", last_name: "joy", school: sch
      @teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true
      create :score_type, id: 1, name: "homework", school: sch
      sub =  create :subject, id: 1, name: "english", classroom: class1, teacher: @teacher
      @login_url = '/api/v1/teacher_auth/sign_in'
      @score_report_drafts_url = '/api/v1/score_report_drafts'

      @score_report_drafts_params = {score_report_draft: {max: 30, subject_id: 1, score_type_id: 1  }}
  
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
        
        post @score_report_drafts_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when teacher is authenticated " do

      subject {  post @score_report_drafts_url, headers: @headers, params: @score_report_drafts_params } 

      context "when new score_report_draft has been created" do
        it "increment ScoreReportDraft by 1" do
          expect{subject}.to change{ScoreReportDraft.count}.by(1)
        end

        it "increment StudentScoreReportDraft by 2" do
          expect{subject}.to change{StudentScoreReportDraft.count}.by(2)
        end

        it "returns http status created " do
          subject
          expect(response).to have_http_status(:created)
        end
        
      end

      context "when new score_report_draft has failed to be created" do

        it "returns http status unprocessable entity " do

          post @score_report_drafts_url, headers: @headers, params: {score_report_draft: {max: nil, subject_id: 1, score_type_id: 1  }}
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




  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      class1 = create :classroom, name: "ss1", school: sch
      @teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true
      score_type = create :score_type, id: 1, name: "homework", school: sch
      sub =  create :subject, id: 1, name: "english", classroom: class1, teacher: @teacher
      sub2 =  create :subject, name: "maths", classroom: class1, teacher: @teacher

      create :score_report_draft, max: 50, published: true, score_type: score_type, subject: sub, teacher: @teacher
      create :score_report_draft, max: 30, published: true, score_type: score_type, subject: sub, teacher: @teacher

      create :score_report_draft, max: 60, published: false, score_type: score_type, subject: sub2, teacher: @teacher



      @login_url = '/api/v1/teacher_auth/sign_in'
      @score_report_drafts_url = '/api/v1/score_report_drafts'

      

     
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
        
        get '/api/v1/score_report_drafts'
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when teacher is authenticated " do

      subject {  get @score_report_drafts_url, headers: @headers } 

      it "returns proper json response of the first score_report_draft" do
        subject
        json_body = JSON.parse(response.body)

        expect(json_body.first).to include({
          "subject" => "english",
          "max" => 50,
          "score_type" => "homework",
          "published" => true
        })
        
      end


      it "returns proper json response of the last score_report_draft" do
        subject
        json_body = JSON.parse(response.body)

        expect(json_body.last).to include({
          "subject" => "maths",
          "max" => 60,
          "score_type" => "homework",
          "published" => false
        })
        
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





  describe "GET /show" do
   
    before do 
      sch = build :school, id: 44
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", middle_name: "paul", school: sch

      @teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true
      score_type = create :score_type, id: 1, name: "homework", school: sch
      sub =  create :subject, id: 1, name: "english", classroom: class1, teacher: @teacher
      sub2 =  create :subject, name: "maths", classroom: class1, teacher: @teacher

      create :score_report_draft, id: 1, max: 50, published: true, score_type: score_type, subject: sub, teacher: @teacher
      create :student_score_report_draft, student: stud1, score: 40, score_report_draft_id: 1
      

      @login_url = '/api/v1/teacher_auth/sign_in'
      @score_report_drafts_url = '/api/v1/score_report_drafts/1'

      

     
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
        
        get @score_report_drafts_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when teacher is authenticated " do

      subject {  get @score_report_drafts_url, headers: @headers } 

      it "returns proper json response of the score_report_draft" do
        subject
        json_body = JSON.parse(response.body)

        expect(json_body["score_report_draft"]).to include({
          "subject" => "english",
          "max" => 50,
          "score_type" => "homework",
          "published" => true
        })
        
      end

      it "returns proper json response of the score_report_draft" do
        subject
        json_body = JSON.parse(response.body)
        
        expect(json_body["student_score_report_drafts"].first).to include({
          "full_name" => "chima paul joy",
          "score" => 40
        })
        
      end


      # it "returns proper json response of the last score_report_draft" do
      #   subject
      #   json_body = JSON.parse(response.body)

      #   expect(json_body.last).to include({
      #     "subject" => "maths",
      #     "max" => 60,
      #     "score_type" => "homework",
      #     "published" => false
      #   })
        
      # end
      

    

    end
    

  end


end
