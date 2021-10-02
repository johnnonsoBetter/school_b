require 'rails_helper'

RSpec.describe "Api::V1::TeacherDashboards", type: :request do
  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      class1 = create :classroom, name: "ss1", school: sch
      @teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true, full_name: "teacher paul"
      @teacher1 = create :teacher, email: "maker@mail.com", password: "password", school: sch, permitted: true
      score_type = create :score_type, id: 1, name: "homework", school: sch
      sub =  create :subject, id: 1, name: "english", classroom: class1, teacher: @teacher
      sub2 =  create :subject, name: "maths", classroom: class1, teacher: @teacher
      sub3 =  create :subject, name: "economics", classroom: class1, teacher: @teacher1

      create :score_report_draft, max: 50, published: true, score_type: score_type, subject: sub2, teacher: @teacher
      create :score_report_draft, max: 28, published: false, score_type: score_type, subject: sub2, teacher: @teacher
      create :score_report_draft, max: 30, published: true, score_type: score_type, subject: sub, teacher: @teacher
      create :score_report_draft, max: 60, published: false, score_type: score_type, subject: sub, teacher: @teacher

      @login_url = '/api/v1/teacher_auth/sign_in'
      @teacher_dashboards_url = '/api/v1/teacher_dashboards'

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
        
        get '/api/v1/teacher_dashboards'
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when teacher is authenticated " do

      subject {  get @teacher_dashboards_url, headers: @headers } 

      it "returns proper json response of the first score_report_draft" do
        subject
        json_body = JSON.parse(response.body)

        expect(json_body["score_report_drafts"].first).to include({
          "subject" => "maths",
          "max" => 28,
          "score_type" => "homework",
          "published" => false
        })
        
      end



      it "returns proper json response of the last score_report_draft" do
        subject
        json_body = JSON.parse(response.body)

        expect(json_body["score_report_drafts"].last).to include({
          "subject" => "english",
          "max" => 60,
          "score_type" => "homework",
          "published" => false
        })
        
      end

      it "returns proper json response of the first teachers subject" do
        subject
        json_body = JSON.parse(response.body)

        expect(json_body["subjects"].first).to include({
          "name" => "english",
        })
        
      end

      it "returns proper json response of the last teachers subject" do
        subject
        json_body = JSON.parse(response.body)

        expect(json_body["subjects"].last).to include({
          "name" => "maths",
        })
        
      end

      it "returns proper json response of teachers full name" do
        subject
        json_body = JSON.parse(response.body)

        expect(json_body["teacher"]).to include({
          "full_name" => "teacher paul"
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
end
