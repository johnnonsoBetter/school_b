require 'rails_helper'

RSpec.describe "Api::V1::AdminStudentScoreReports", type: :request do
  before do 
    sch = build :school, id: 44
    
    class1 = create :classroom, name: "ss1", school: sch
    stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
    stud2 = create :student, classroom: class1, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
    stud3 = create :student, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"
    score_t1 = create :score_type, name: "homework", school: sch
    score_t2 = create :score_type, name: "exam", school: sch


    @admin = create :admin, email: "mak3er@gmail.com", password: "password", school: sch
    @admin2 = create :admin, email: "shdfgdgfisf@gmail.com", password: "password", school: sch 

    teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch 


    eng = create :subject, name: "english", classroom: class1, teacher: teacher
    maths =  create :subject, name: "mathematics", classroom: class1, teacher: teacher

    term_date = create :term_date, id: 1, name: "1st term 2021/2021", start_date: Date.new(2021, 9, 4), end_date: Date.new(2021, 12, 11)
     
    create :score_report, max: 10, score: 7, student: stud1, subject: maths, teacher: teacher, score_type: score_t1, created_at: Date.new(2020, 10, 11)
    create :score_report, max: 20, score: 10, student: stud1, subject: eng, teacher: teacher, score_type: score_t1, created_at: Date.new(2021, 10, 11)
    create :score_report, max: 20, score: 15, student: stud1, subject: maths, teacher: teacher, score_type: score_t1, created_at: Time.now
    create :score_report, max: 10, score: 5, student: stud1, subject: eng, teacher: teacher, score_type: score_t2, created_at: Time.now
     
     
    

    @login_url = '/api/v1/auth/sign_in'
    @admin_student_score_reports_url = '/api/v1/admin_student_score_reports'

    @admin_params = {
      email: @admin.email,
      password: @admin.password
    }

    
   
  end

  context "when admin is not authenticated" do
    it "return http status unauthorized" do
      
      get @admin_student_score_reports_url
      expect(response).to have_http_status(:unauthorized)  
    end
    
  end

  context "when admin is authenticated " do
    
    before do 
      post @login_url, params: @admin_params
      
      @headers = {
        'access-token' => response.headers['access-token'],
        'client' => response.headers['client'],
        'uid' => response.headers['uid']
      }

     
     
    end

    context "when term params termid is available and params score type is exam " do
      
      before do 

        get @admin_student_score_reports_url, headers: @headers, params: {student_id: 34, term_id: 1, score_type: "exam"}
        @json_body = JSON.parse(response.body)
        
        
      end


     
        it "returns proper json response of the first score report of stud1" do
          expect(@json_body.first).to include({
            'max' => 10,
            'score' => 5,
            'subject' => 'english',
            'score_type' => 'exam',
            
          })  
        end


      it "returns proper json response of the last score report of stud1" do
        expect(@json_body.last).to include({
          'max' => 10,
          'score' => 5,
          'subject' => 'english',
          'score_type' => 'exam',
          
        })  
      end

    end


    context "when term params termid is available and params score type is all " do
      
      before do 

        get @admin_student_score_reports_url, headers: @headers, params: {student_id: 34, term_id: 1, score_type: "all"}
        @json_body = JSON.parse(response.body)
        
        
      end


      it "returns proper json response of the first score report of stud1" do

        
        expect(@json_body.first).to include({
          'max' => 20,
          'score' => 10,
          'subject' => 'english',
          'score_type' => 'homework',
          
        })  
      end

      it "returns proper json response of the last score report of stud1" do
        expect(@json_body.last).to include({
          'max' => 10,
          'score' => 5,
          'subject' => 'english',
          'score_type' => 'exam',
          
        })  
      end

    end


   
    

  end
  

end
