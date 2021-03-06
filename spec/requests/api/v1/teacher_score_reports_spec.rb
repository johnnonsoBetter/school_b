require 'rails_helper'

RSpec.describe "Api::V1::TeacherScoreReports", type: :request do
  describe "GET /index" do
    
    before do 
      sch = build :school, id: 44
      
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", middle_name: "po", last_name: "joy", school: sch
      stud2 = create :student, classroom: class1, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
      stud3 = create :student, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna", middle_name: "jamu"
      score_t1 = create :score_type, id: 1, name: "homework", school: sch
      score_t2 = create :score_type, id: 2, name: "exam", school: sch
    
      first_term = create :term_date, id: 1, name: "1st term 2021/2022", start_date: Date.new(2021, 1, 1), end_date: Date.new(2021, 4, 1)
      secound_term = create :term_date, id: 2, name: "2st term 2021/2022", start_date: Date.new(2021, 5, 1), end_date: Date.new(2021, 8, 1)
      third_term = create :term_date, id: 3, name: "3st term 2021/2022", start_date: Date.new(2021, 9, 1), end_date: Date.new(2021, 12, 1)
  

      @teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true
 
      eng = create :subject, id: 1, name: "english", classroom: class1, teacher: @teacher
      maths =  create :subject, id: 2, name: "mathematics", classroom: class1, teacher: @teacher
      econs =  create :subject, id: 3, name: "economics", classroom: class1, teacher: @teacher

      create :score_report, max: 10, score: 5, student: stud1, subject: eng, teacher: @teacher, score_type: score_t1, created_at: first_term.start_date
      create :score_report, max: 10, score: 7, student: stud2, subject: maths, teacher: @teacher, score_type: score_t1, created_at: first_term.start_date
      create :score_report, max: 28, score: 15, student: stud3, subject: econs, teacher: @teacher, score_type: score_t2, created_at: first_term.end_date
      create :score_report, max: 20, score: 9, student: stud3, subject: maths, teacher: @teacher, score_type: score_t1, created_at: secound_term.start_date
      create :score_report, max: 20, score: 15, student: stud2, subject: econs, teacher: @teacher, score_type: score_t1, created_at: third_term.start_date
      create :score_report, max: 20, score: 7, student: stud1, subject: eng, teacher: @teacher, score_type: score_t1, created_at: third_term.end_date
      create :score_report, max: 30, score: 15, student: stud2, subject: econs, teacher: @teacher, score_type: score_t1, created_at: third_term.start_date
      create :score_report, max: 20, score: 10, student: stud1, subject: maths, teacher: @teacher, score_type: score_t1, created_at: first_term.start_date
      create :score_report, max: 20, score: 10, student: stud1, subject: eng, teacher: @teacher, score_type: score_t1, created_at: secound_term.end_date


      @login_url = '/api/v1/teacher_auth/sign_in'
      @teacher_score_reports_url = '/api/v1/teacher_score_reports'
  
      @teacher_params = {
        email: @teacher.email,
        password: @teacher.password
      }

      
     
    end

    context "when teacher is not authenticated" do
      it "return http status unauthorized" do
        
        get @teacher_score_reports_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when teacher is authenticated " do
      
      before do 
        post @login_url, params: @teacher_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

       
       
      end


      context "when teacher is not permitted " do

        it "returns https status code 401 unauthorized" do
          
          @teacher.permitted = false
          @teacher.save 
          get @teacher_score_reports_url, headers: @headers, params: {term_date_id: 1, subject_id: 3, score_type_id: 1}
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end

      context "when the teacher is trying to query score type of home work and english of first term  " do
        
        before do 

          get @teacher_score_reports_url, headers: @headers, params: {term_date_id: 1, subject_id: 1, score_type_id: 1}
          @json_body = JSON.parse(response.body)
          
          
        end


        it "returns proper json response of the first score reports" do
          expect(@json_body.first).to include({
            'max' => 10,
            'score' => 5,
            'student' => "chima po joy",
            'score_type' => 'homework',
            
          })  
        end

        it "returns proper json response of the first score reports" do
          expect(@json_body.last).to include({
            'max' => 10,
            'score' => 5,
            'student' => "chima po joy",
            'score_type' => 'homework',
            
          })  
        end

        
      end
      


      

    end
    
    

  end
end
