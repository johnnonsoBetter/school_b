require 'rails_helper'

RSpec.describe "Api::V1::GuidanceScoreReports", type: :request do
  describe "GET /index" do
    
    before do 
      sch = build :school, id: 44
      
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
      stud2 = create :student, classroom: class1, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
      stud3 = create :student, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"
      score_t1 = create :score_type, name: "homework", school: sch
  
      @guidance = create :guidance, email: "mak3er@gmail.com", password: "password"
      @guidance2 = create :guidance, email: "shdfgdgfisf@gmail.com", password: "password"

      teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch 

 
      eng = create :subject, name: "english", classroom: class1, teacher: teacher
      maths =  create :subject, name: "mathematics", classroom: class1, teacher: teacher

       create :score_report, max: 10, score: 5, student: stud1, subject: eng, teacher: teacher, score_type: score_t1, created_at: Time.now
       create :score_report, max: 10, score: 7, student: stud1, subject: maths, teacher: teacher, score_type: score_t1, created_at: Time.new.prev_day
       
       create :score_report, max: 20, score: 15, student: stud1, subject: maths, teacher: teacher, score_type: score_t1, created_at: Time.now
       create :score_report, max: 20, score: 10, student: stud1, subject: eng, teacher: teacher, score_type: score_t1, created_at: Time.new.prev_day
       
      

      @guidance.students << stud1
      @guidance.students << stud3
      @guidance2.students << stud2
  


      @login_url = '/api/v1/guidance_auth/sign_in'
      @guidance_score_reports_url = '/api/v1/guidance_score_reports'
  
      @guidance_params = {
        email: @guidance.email,
        password: @guidance.password
      }

      
     
    end

    context "when guidance is not authenticated" do
      it "return http status unauthorized" do
        
        get @guidance_score_reports_url
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

       
       
      end


      context "when date params is today " do
        
        before do 

          get @guidance_score_reports_url, headers: @headers, params: {student_id: 34, date: Time.now}
          @json_body = JSON.parse(response.body)
          
          
        end


        it "returns proper json response of the first score report of stud1" do
          expect(@json_body.first).to include({
            'max' => 10,
            'score' => 5,
            'subject' => 'english',
            'score_type' => 'homework',
            
          })  
        end

        it "returns proper json response of the last score report of stud1" do
          expect(@json_body.last).to include({
            'max' => 20,
            'score' => 15,
            'subject' => 'mathematics',
            'score_type' => 'homework',
            
          })  
        end

      end
      


      

      
    end
    
    

  end
end
