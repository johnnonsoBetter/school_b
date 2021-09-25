require 'rails_helper'

RSpec.describe "Api::V1::GuidanceBehaviourReports", type: :request do
  describe "GET /index" do
    describe "GET /index" do
    
      before do 
        sch = build :school, id: 44
        
        class1 = create :classroom, name: "ss1", school: sch
        stud1 = create :student, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
        stud2 = create :student, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
        stud3 = create :student, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"
   
    
        @guidance = create :guidance, email: "mak3er@gmail.com", password: "password"
        @guidance2 = create :guidance, email: "shdfgdgfisf@gmail.com", password: "password"
  
        teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch 
  
   
        
         create :behaviour_report, title: "noise maker", teacher: teacher, student: stud1, behaviour_type: "bad", created_at: Time.now
         create :behaviour_report, title: "troublesome", teacher: teacher, student: stud1, behaviour_type: "bad", created_at: Time.new.prev_day
         create :behaviour_report, title: "great performance", teacher: teacher, student: stud1, behaviour_type: "good", created_at: Time.now
         create :behaviour_report, title: "listener", teacher: teacher, student: stud1, behaviour_type: "good", created_at: Time.new.prev_day
        
        
  
        @guidance.students << stud1
        @guidance.students << stud3
        @guidance2.students << stud2
    
  
  
        @login_url = '/api/v1/guidance_auth/sign_in'
        @guidance_behaviour_reports_url = '/api/v1/guidance_behaviour_reports'
    
        @guidance_params = {
          email: @guidance.email,
          password: @guidance.password
        }
  
        
       
      end
  
      context "when guidance is not authenticated" do
        it "return http status unauthorized" do
          
          get @guidance_behaviour_reports_url
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
  
            get @guidance_behaviour_reports_url, headers: @headers, params: {student_id: 34, date: Time.now}
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

        context "when date params is yesterday " do
          
          before do 
  
            get @guidance_behaviour_reports_url, headers: @headers, params: {student_id: 34, date: Time.new.prev_day}
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
end
