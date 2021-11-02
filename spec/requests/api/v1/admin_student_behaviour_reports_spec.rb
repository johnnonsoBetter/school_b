require 'rails_helper'

RSpec.describe "Api::V1::AdminStudentBehaviourReports", type: :request do
 
      before do 
        sch = build :school, id: 44
        
        class1 = create :classroom, name: "ss1", school: sch
        stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
        stud2 = create :student, classroom: class1, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
        stud3 = create :student, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"
   
    
        term_date = create :term_date, id: 1, name: "1st term 2021/2021", start_date: Date.new(2021, 9, 4), end_date: Date.new(2021, 12, 11)
    
        teacher = create :teacher, email: "teacher@mail.com", password: "password", school: sch 
        @admin = create :admin, email: "mak3er@gmail.com", password: "password", school: sch
   
        
        create :behaviour_report, title: "noise maker", teacher: teacher, student: stud1, behaviour_type: "bad", created_at: Date.new(2020, 9, 4)
        create :behaviour_report, title: "troublesome", teacher: teacher, student: stud1, behaviour_type: "bad", created_at: Date.new(2021, 9, 4)
        
        create :behaviour_report, title: "listener", teacher: teacher, student: stud1, behaviour_type: "good", created_at: Time.new.prev_day
        create :behaviour_report, title: "great performance", teacher: teacher, student: stud1, behaviour_type: "good", created_at: Time.now
       

        @login_url = '/api/v1/auth/sign_in'
        @admin_student_behaviour_reports_url = '/api/v1/admin_student_behaviour_reports'
    
        @admin_params = {
          email: @admin.email,
          password: @admin.password
        }
  
      end
  
      context "when admin is not authenticated" do
        it "return http status unauthorized" do
          
          get @admin_student_behaviour_reports_url
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
  
  
        context "when term id params exists" do
          
          before do 
  
            get @admin_student_behaviour_reports_url, headers: @headers, params: {student_id: 34, term_id: 1}
            @json_body = JSON.parse(response.body)
            
            
          end
  
          it "returns proper json response of the first behaviour report of stud1" do
            expect(@json_body['behaviour_reports'].first).to include({
              'title' => "troublesome",             
              'behaviour_type' => 'bad',
  
            })  
          end 

          it "returns proper json response of the last behaviour report of stud1" do
            expect(@json_body['behaviour_reports'].last).to include({
              'title' => "great performance",
              'behaviour_type' => 'good',
            })  
          end
  
        end

       
        

      end
      

end
