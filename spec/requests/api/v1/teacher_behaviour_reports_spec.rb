require 'rails_helper'

RSpec.describe "Api::V1::TeacherBehaviourReports", type: :request do


  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
      @teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true
      @behaviour_report_params = {behaviour_report: {title: "Noise Maker", description: "we have noticed that chi always makes noise", behaviour_type: "bad", student_id: stud1.id}}

      @login_url = '/api/v1/teacher_auth/sign_in'
      @teacher_behaviour_reports_url = '/api/v1/teacher_behaviour_reports'
  
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
        
        post @teacher_behaviour_reports_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when teacher is authenticated " do

      subject {  post @teacher_behaviour_reports_url, headers: @headers, params: @behaviour_report_params } 

      context "when new behaviour report has been created" do
        it "increment behaviour report by 1" do
          expect{subject}.to change{BehaviourReport.count}.by(1)
        end

        it "returns http status created " do
          subject
          expect(response).to have_http_status(:created)
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
      stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
      stud2 = create :student, classroom: class1, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
      stud3 = create :student, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"
 
  
    

      @teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch, permitted: true

 
      
       create :behaviour_report, title: "noise maker", teacher: @teacher, student: stud1, behaviour_type: "bad", created_at: Time.now
       create :behaviour_report, title: "troublesome", teacher: @teacher, student: stud1, behaviour_type: "bad", created_at: Time.new.prev_day
       create :behaviour_report, title: "great performance", teacher: @teacher, student: stud1, behaviour_type: "good", created_at: Time.now
       create :behaviour_report, title: "listener", teacher: @teacher, student: stud1, behaviour_type: "good", created_at: Time.new.prev_day
      
      



      @login_url = '/api/v1/teacher_auth/sign_in'
      @teacher_behaviour_reports_url = '/api/v1/teacher_behaviour_reports'
  
      @teacher_params = {
        email: @teacher.email,
        password: @teacher.password
      }

      
     
    end

    context "when teacher is not authenticated" do
      it "return http status unauthorized" do
        
        get @teacher_behaviour_reports_url
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


      context "when date params is today " do
        
        before do 

          get @teacher_behaviour_reports_url, headers: @headers, params: {student_id: 34, date: Time.now}
          @json_body = JSON.parse(response.body)
          
          
        end

        it "returns proper json response of the first behaviour report of stud1" do
          expect(@json_body.first).to include({
            'title' => "noise maker",             
            'behaviour_type' => 'bad',

          })  
        end 

        it "returns proper json response of the last behaviour report of stud1" do
          expect(@json_body.last).to include({
            'title' => "great performance",
            'behaviour_type' => 'good',
          })  
        end

      end

      context "when teacher is not permitted " do

        it "returns https status code 401 unauthorized" do
          @teacher.permitted = false
          @teacher.save 
          get @teacher_behaviour_reports_url, headers: @headers, params: {student_id: 34, date: Time.new.prev_day}
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end

      context "when date params is yesterday " do
        
        before do 

          get @teacher_behaviour_reports_url, headers: @headers, params: {student_id: 34, date: Time.new.prev_day}
          @json_body = JSON.parse(response.body)
          
          
        end

        it "returns proper json response of the first behaviour report of stud1" do
          expect(@json_body.first).to include({
            'title' => "troublesome",             
            'behaviour_type' => 'bad',

          })  
        end 

        it "returns proper json response of the last behaviour report of stud1" do
          expect(@json_body.last).to include({
            'title' => "listener",
            'behaviour_type' => 'good',
          })  
        end

      end
      


      

      
    end
    

  end
end
