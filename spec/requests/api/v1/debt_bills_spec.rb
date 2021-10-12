require 'rails_helper'

RSpec.describe "Api::V1::DebtBills", type: :request do
 
  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
  
    
      term_date = create :term_date, id: 1, name: "1st term 2021/2021", start_date: Date.new(2021, 9, 4), end_date: Date.new(2021, 10, 11)

      class1 = create :classroom, id: 1, name: "ss1", school: sch
      class2 = create :classroom, id: 2, name: "ss2", school: sch
      
      stud1 = create :student, id: 1, classroom: class1,  email: "st@mail.com", password: "password", school: sch, total_debt: 1200
      stud2 = create :student, id: 2, classroom: class2, school: sch, email: "chisfs1@gmail.com", password: "password", first_name: "ani", last_name: "micheal"

      bill_report = create :bill_report, title: "exam fee", admin: @admin, school: sch, amount: 1500 
      bill_report2 = create :bill_report, title: "a fee", admin: @admin, school: sch, amount: 500 
      bill_report3 = create :bill_report, title: "b fee", admin: @admin, school: sch, amount: 200 


      @b1 = create :bill, id: 1 , payment_completed: false, student: stud1, bill_report: bill_report, paid: 500, balance: 1000

      
      b2 =  create :bill, payment_completed: false, student: stud1, bill_report: bill_report2, paid: 300, balance: 200
      b3 =  create :bill, payment_completed: true, student: stud1, bill_report: bill_report3, paid: 200, balance: 0

      create :payment_history, amount: 250, bill: @b1 
      create :payment_history, amount: 250, bill: @b1 

      create :payment_history, amount: 300, bill: b2
      create :payment_history, amount: 200, bill: b3


     

     

      @login_url = '/api/v1/auth/sign_in'
      @debt_bills_url = '/api/v1/debt_bills/'
  
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
        
        get @debt_bills_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  get @debt_bills_url, headers: @headers, params: {student_id: 1} } 

      context "when admin is permitted " do
        
        before do 

          subject
          @json_body = JSON.parse(response.body)

 
        end

     
        

        it "returns proper json response of the first data of debt_bills" do
          expect(@json_body.first).to include({
            'paid' => 500,
            'balance' => 1000
            
          })     
        end

        it "returns proper first payment history json response of the first data of debt_bills" do
          expect(@json_body.first['payment_histories'].first).to include({
            'amount' => 250,
            
            
          })     
        end

        it "returns proper last payment history json response of the first data of debt_bills" do
          expect(@json_body.first['payment_histories'].last).to include({
            'amount' => 250,
            
            
          })     
        end

        it "returns proper json response of the last data of debt_bills" do
          expect(@json_body.last).to include({
            'paid' => 300,
            'balance' => 200
            
          })     
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


      
      

    end

    
    

  end
end
