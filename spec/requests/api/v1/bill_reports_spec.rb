require 'rails_helper'

RSpec.describe "Api::V1::BillReports", type: :request do
  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      
      @bill_report_params = {bill_report: {amount: 700, title: "excursion fee", optional: false}, classroom_ids: [1, 3]}
      class1 = create :classroom, id: 1, name: "ss1", school: sch
      class2 = create :classroom, id: 2, name: "ss2", school: sch
      
      stud1 = create :student, id: 1, classroom: class1, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
      stud2 = create :student, id: 2, classroom: class2, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
      stud3 = create :student, id: 3, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"


      bill_report = create :bill_report, title: "school fee", admin: @admin, school: sch, amount: 700
      bill_report2 = create :bill_report, title: "exam fee", admin: @admin, school: sch, amount: 1500 

      b1 = create :bill,  payment_completed: false, student: stud1, bill_report: bill_report
      
      b2 =  create :bill, payment_completed: true, student: stud2, bill_report: bill_report2

      create :payment_history, amount: 300, bill: b1 
      create :payment_history, amount: 1500, bill: b2
     
      @login_url = '/api/v1/auth/sign_in'
      @bill_report_url = '/api/v1/bill_reports'
  
      @admin_params = {
        email: @admin.email,
        password: @admin.password
      }

      post @login_url, params: @admin_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

    end

    context "when admin is not authenticated" do
      it "return http status unauthorized" do
        
        post @bill_report_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  post @bill_report_url, headers: @headers, params: @bill_report_params } 

      context "when new bill_report report has been created" do
        it "increment bill_report report by 1" do
          expect{subject}.to change{BillReport.count}.by(1)
        end

        it "increment bills report by 3" do
          expect{subject}.to change{Bill.count}.by(2)
        end

        it "updates student 1 total debt" do
          subject
          student = Student.find(1)
          expect(student.total_debt).to eq(1100) 
        end

       
        

        it "returns http status created " do
          subject
          expect(response).to have_http_status(:created)
        end
        
      end

      context "when admin is not permitted " do

        it "returns https status code 401 unauthorized" do
          @admin.permitted = false
          @admin.save 
          subject
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end
      

      context "when new bill_report failed to be created" do

        subject {  post @bill_report_url, headers: @headers, params: {bill_report: {amount: 700, title: "", optional: false}, classroom_ids: [1, 3]} } 


        it "does not increment bill_report report by 1" do
          expect{subject}.not_to change{BillReport.count}
        end

        it "returns htpp status code unprocessable entity" do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
          
        end

      end
 
    end
    

  end



  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true, full_name: "bose peter"
      
      class1 = create :classroom, id: 1, name: "ss1", school: sch
      class2 = create :classroom, id: 2, name: "ss2", school: sch
      
      stud1 = create :student, id: 1, classroom: class1, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
      stud2 = create :student, id: 2, classroom: class2, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
      stud3 = create :student, id: 3, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"


      bill_report = create :bill_report, title: "school fee", admin: @admin, school: sch, amount: 700
      bill_report2 = create :bill_report, title: "exam fee", admin: @admin, school: sch, amount: 1500 
      create :bill_report, title: "lecture fee", admin: @admin, school: sch, amount: 9000 

     




      @login_url = '/api/v1/auth/sign_in'
      @bill_report_url = '/api/v1/bill_reports'
  
      @admin_params = {
        email: @admin.email,
        password: @admin.password
      }

      post @login_url, params: @admin_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

    end

    context "when admin is not authenticated" do
      it "return http status unauthorized" do
        
        get @bill_report_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  get @bill_report_url, headers: @headers} 

      

      it "returns proper json response of first bill reports" do

        subject
        json_body = JSON.parse(response.body)

        expect(json_body.first).to include({
          'title' => 'school fee',
          'amount' => 700,
          'admin' => 'bose peter'
        })  
        
      end

      it "returns proper json response of last bill reports" do

        subject
        json_body = JSON.parse(response.body)

        expect(json_body.last).to include({
          'title' => 'lecture fee',
          'amount' => 9000,
          'admin' => 'bose peter'
        })  
        
      end
      

      context "when admin is not permitted " do

        it "returns https status code 401 unauthorized" do
          @admin.permitted = false
          @admin.save 
          subject
          expect(response).to have_http_status(:unauthorized)  
        end
        
        
      end
      

     
 
    end
    

  end
end
