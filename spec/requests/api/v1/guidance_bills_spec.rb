require 'rails_helper'

RSpec.describe "Api::V1::GuidanceBills", type: :request do
  describe "GET /index" do
    
    before do 
      sch = build :school, id: 44
      admin = create :admin, email: "ad@gmail.com", password: "password", school: sch
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
      stud2 = create :student, classroom: class1, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
      stud3 = create :student, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"
      
      @guidance = create :guidance, email: "mak3er@gmail.com", password: "password"
      @guidance2 = create :guidance, email: "shdfgdgfisf@gmail.com", password: "password"
      bill_report = create :bill_report, title: "school fee", admin: admin, school: sch, amount: 700
      bill_report2 = create :bill_report, title: "exam fee", admin: admin, school: sch, amount: 1500 

      create :bill,  payment_completed: true, student: stud1, bill_report: bill_report
      create :bill, payment_completed: true, student: stud2, bill_report: bill_report
      create :bill, payment_completed: false, student: stud1, bill_report: bill_report2
      create :bill, payment_completed: false, student: stud2, bill_report: bill_report

     

      @guidance.students << stud1
      @guidance.students << stud3
      @guidance2.students << stud2
  


      @login_url = '/api/v1/guidance_auth/sign_in'
      @guidance_bills_url = '/api/v1/guidance_bills'
  
      @guidance_params = {
        email: @guidance.email,
        password: @guidance.password
      }

      
     
    end

    context "when guidance is not authenticated" do
      it "return http status unauthorized" do
        
        get @guidance_bills_url
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


      context "when student id exists " do
        
        before do 

          get @guidance_bills_url, headers: @headers, params: {student_id: 34}
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

  describe "GET /show" do
    
    before do 
      sch = build :school, id: 44
      admin = create :admin, email: "ad@gmail.com", password: "password", school: sch
      class1 = create :classroom, name: "ss1", school: sch
      stud1 = create :student, classroom: class1, id: 34, email: "chi@gmail.com", password: "password", first_name: "chima", last_name: "joy", school: sch
      stud2 = create :student, classroom: class1, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"
      stud3 = create :student, classroom: class1, school: sch, email: "chisdf2@gmail.com", password: "password", first_name: "praise", last_name: "luna"
      bill_report = create :bill_report, title: "school fee", admin: admin, school: sch, amount: 700 

      @guidance = create :guidance, email: "mak3er@gmail.com", password: "password"
      @guidance2 = create :guidance, email: "shdfgdgfisf@gmail.com", password: "password"

      b1 = create :bill, id: 4,  payment_completed: true, student: stud1, bill_report: bill_report
      create :bill, payment_completed: true, student: stud2, bill_report: bill_report
      create :bill, payment_completed: false, student: stud1, bill_report: bill_report
      create :bill, payment_completed: true, student: stud2, bill_report: bill_report

      create :payment_history, amount: 300, bill: b1 
      create :payment_history, amount: 300, bill: b1 
      create :payment_history, amount: 100, bill: b1 


     

      @guidance.students << stud1
      @guidance.students << stud3
      @guidance2.students << stud2
  


      @login_url = '/api/v1/guidance_auth/sign_in'
      @guidance_bills_url = '/api/v1/guidance_bills/4'
  
      @guidance_params = {
        email: @guidance.email,
        password: @guidance.password
      }

      
     
    end

    context "when guidance is not authenticated" do
      it "return http status unauthorized" do
        
        get @guidance_bills_url
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


      context "when student id exists " do
        
        before do 

          get @guidance_bills_url, headers: @headers, params: {student_id: 34}
          @json_body = JSON.parse(response.body)
          
          
        end


        it "returns proper json response containing studentd1 bill information" do
          expect(@json_body['bill']).to include({
            "title"  => "school fee",
            "amount" => 700,
            "payment_completed" => true
          })  
        end

        it "returns proper json of bill first payment history" do
          expect(@json_body["payment_histories"].first).to include({
            "amount" => 300
          })  
        end

        it "returns proper json of bill last payment history " do
          expect(@json_body["payment_histories"].last).to include({
            "amount" => 100
          })  
        end


      end
      


      

      
    end
    
    

  end











end
