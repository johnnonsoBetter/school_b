require 'rails_helper'

RSpec.describe "Api::V1::AdminStudentBills", type: :request do
  describe "GET /index" do
    
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "ad@gmail.com", password: "password", school: sch
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
      stud2 = create :student, classroom: class1, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
      stud3 = create :student, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"
      
      
      bill_report = create :bill_report, title: "school fee", admin: @admin, school: sch, amount: 700
      bill_report2 = create :bill_report, title: "exam fee", admin: @admin, school: sch, amount: 1500 

      create :bill,  payment_completed: true, student: stud1, bill_report: bill_report
      create :bill, payment_completed: true, student: stud2, bill_report: bill_report
      create :bill, payment_completed: false, student: stud1, bill_report: bill_report2
      create :bill, payment_completed: false, student: stud2, bill_report: bill_report

      @login_url = '/api/v1/auth/sign_in'
      @admin_student_bills_url = '/api/v1/admin_student_bills'
  
      @admin_params = {
        email: @admin.email,
        password: @admin.password
      }

      
     
    end

    context "when admin is not authenticated" do
      it "return http status unauthorized" do
        
        get @admin_student_bills_url
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


      context "when student id exists " do
        
        before do 

          get @admin_student_bills_url, headers: @headers, params: {student_id: 34}
          @json_body = JSON.parse(response.body)
          
          
        end


        it "returns proper json response of the first bill  of stud1" do
          expect(@json_body.first).to include({
            "title"  => "school fee",
            "amount" => 700,
            "payment_completed" => true
          })  
        end

        it "returns proper json response of the last bill  of stud1" do
          expect(@json_body.last).to include({
            "title"  => "exam fee",
            "amount" => 1500,
            "payment_completed" => false
          })  
        end

      end
      


      

      
    end
    
    

  end

end
