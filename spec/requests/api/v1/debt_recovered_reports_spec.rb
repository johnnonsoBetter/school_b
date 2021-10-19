
require 'rails_helper'

RSpec.describe "Api::V1::DebtRecoveredReports", type: :request do
  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
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
      # create :payment_history, amount: 1500, bill: b2
     

     
      @debt_recovered_report_params = {debt_recovered_report: {amount: 500, bill_id: 1, }}

      @login_url = '/api/v1/auth/sign_in'
      @debt_recovered_report_url = '/api/v1/debt_recovered_reports'
  
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
        
        post @debt_recovered_report_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  post @debt_recovered_report_url, headers: @headers, params: @debt_recovered_report_params } 

      context "when new debt_recovered_report report has been created" do
        it "increment debt_recovered_report report by 1" do
          expect{subject}.to change{DebtRecoveredReport.count}.by(1)
        end

        it "increment payment history count by 1" do
          expect{subject}.to change{PaymentHistory.count}.by(1)
        end

        it "increment bill payment histores count by 2" do
          subject
          expect(Bill.find(1).payment_histories.count).to eq(3)
        end

        it "update bill balance to 500" do
          subject
          expect(Bill.find(1).balance).to eq(500)
        end

        it "update bill paid to 1000" do
          subject
          expect(Bill.find(1).paid).to eq(1000)
        end

        it "updates the student total debt to 700" do
          subject
          expect(Student.find(1).total_debt).to eq(700)  
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
      

      context "when new debt_recovered_report failed to be created" do


          it "do not increment debt_recovered_report report " do
            expect{post @debt_recovered_report_url, headers: @headers, params: {debt_recovered_report: {amount: 500, bill_id: 4, }} }.to_not change{DebtRecoveredReport.count}
          end

          it "returns htpp status code unprocessable entity" do
            post @debt_recovered_report_url, headers: @headers, params: {debt_recovered_report: {amount: 0, bill_id: 1,}}
            expect(response).to have_http_status(:unprocessable_entity)

          end

          it "returns htpp status code unprocessable entity" do
            create :payment_history, amount: 800, bill: @b1 
            post @debt_recovered_report_url, headers: @headers, params: {debt_recovered_report: {amount: 500, bill_id: 1,}}
            expect(response).to have_http_status(:unprocessable_entity)
            

          end

 
       end

    end
    

  end




  
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


     

      create :debt_recovered_report, school: sch, admin: @admin, amount: 100, created_at: Date.new(2020, 10, 4), bill_id: @b1.id
      create :debt_recovered_report, school: sch, admin: @admin, amount: 300, created_at: Date.new(2021, 9, 4), bill_id: b2.id

      create :debt_recovered_report, school: sch, admin: @admin, amount: 600, created_at: Date.new(2021, 10, 8), bill_id: @b1.id

      create :debt_recovered_report, school: sch, admin: @admin, amount: 950, created_at: Date.new(2021, 10, 11), bill_id: @b1.id

      create :debt_recovered_report, school: sch, admin: @admin, amount: 110, created_at: Time.now, bill_id: b2.id

      create :debt_recovered_report, school: sch, admin: @admin, amount: 450, created_at: Time.now, bill_id: b2.id
      
      
      
     

      @login_url = '/api/v1/auth/sign_in'
      @debt_recovered_report_url = '/api/v1/debt_recovered_reports/'
  
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
        
        get @debt_recovered_report_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  get @debt_recovered_report_url, headers: @headers } 

      context "when term_id params exists" do
        subject {  get @debt_recovered_report_url, headers: @headers, params: {term_id: 1} } 

        before do 

          subject
          @json_body = JSON.parse(response.body)

 
        end

     
        

        it "returns proper json response of the first data of debt_recovered_reports" do
          expect(@json_body.first).to include({
            'amount' => 300
            
          })     
        end

        it "returns proper json response of the last data of debt_recovered_reports" do
          expect(@json_body.last).to include({
            'amount' => 950
            
          })     
        end
        
        
      end

      context "when date params exists" do
        subject {  get @debt_recovered_report_url, headers: @headers, params: {date: Time.now} } 

        before do 

          subject
          @json_body = JSON.parse(response.body)


        end

        it "returns proper json response of the first data of debt_recovered_reports" do
          expect(@json_body.first).to include({
            'amount' => 110
            
          })     
        end

        it "returns proper json response of the last data of debt_recovered_reports" do
          expect(@json_body.last).to include({
            'amount' => 450
            
          })     
        end
        
        
      end

      context "when range params exists" do
        subject {  get @debt_recovered_report_url, headers: @headers, params: {from: Date.new(2021, 10, 8), to: Date.new(2021, 10, 11)} } 

        before do 

          subject
          @json_body = JSON.parse(response.body)


        end

        it "returns proper json response of the first data of debt_recovered_reports" do
          expect(@json_body.first).to include({
            'amount' => 600
            
          })     
        end

        it "returns proper json response of the last data of debt_recovered_reports" do
          expect(@json_body.last).to include({
            'amount' => 950
            
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
