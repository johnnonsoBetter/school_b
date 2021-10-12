
require 'rails_helper'

RSpec.describe "Api::V1::ExpenseReports", type: :request do
  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
     
      @expense_report_params = {expense_report: {amount: 500, title: "food" }}

      @login_url = '/api/v1/auth/sign_in'
      @expense_report_url = '/api/v1/expense_reports'
  
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
        
        post @expense_report_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  post @expense_report_url, headers: @headers, params: @expense_report_params } 

      context "when new expense_report report has been created" do
        it "increment expense_report report by 1" do
          expect{subject}.to change{ExpenseReport.count}.by(1)
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
      

      context "when new expense_report failed to be created" do


          it "do not increment expense_report report " do
            expect{post @expense_report_url, headers: @headers, params: {expense_report: {amount: 350, title: ""}} }.to_not change{ExpenseReport.count}
          end

          it "returns htpp status code unprocessable entity" do
            post @expense_report_url, headers: @headers, params: {expense_report: {amount: 0, title: "transportation"}}
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

      create :expense_report, school: sch, admin: @admin, amount: 100, created_at: Date.new(2020, 10, 4)
      create :expense_report, school: sch, admin: @admin, amount: 300, created_at: Date.new(2021, 9, 4)

      create :expense_report, school: sch, admin: @admin, amount: 600, created_at: Date.new(2021, 10, 8)

      create :expense_report, school: sch, admin: @admin, amount: 950, created_at: Date.new(2021, 10, 11)

      create :expense_report, school: sch, admin: @admin, amount: 110, created_at: Time.now

      create :expense_report, school: sch, admin: @admin, amount: 450, created_at: Time.now
      
      
      
     

      @login_url = '/api/v1/auth/sign_in'
      @expense_report_url = '/api/v1/expense_reports/'
  
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
        
        get @expense_report_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  get @expense_report_url, headers: @headers } 

      context "when term_id params exists" do
        subject {  get @expense_report_url, headers: @headers, params: {term_id: 1} } 

        before do 

          subject
          @json_body = JSON.parse(response.body)


        end

     
        it "returns proper json response of the first data of expense_reports" do
          expect(@json_body.first).to include({
            'amount' => 300
            
          })     
        end

        it "returns proper json response of the last data of expense_reports" do
          expect(@json_body.last).to include({
            'amount' => 950
            
          })     
        end
        
        
      end

      context "when date params exists" do
        subject {  get @expense_report_url, headers: @headers, params: {date: Time.now} } 

        before do 

          subject
          @json_body = JSON.parse(response.body)


        end

        it "returns proper json response of the first data of expense_reports" do
          expect(@json_body.first).to include({
            'amount' => 110
            
          })     
        end

        it "returns proper json response of the last data of expense_reports" do
          expect(@json_body.last).to include({
            'amount' => 450
            
          })     
        end
        
        
      end

      context "when range params exists" do
        subject {  get @expense_report_url, headers: @headers, params: {date_range: {from: Date.new(2021, 10, 8), to: Date.new(2021, 10, 11)}} } 

        before do 

          subject
          @json_body = JSON.parse(response.body)


        end

        it "returns proper json response of the first data of expense_reports" do
          expect(@json_body.first).to include({
            'amount' => 600
            
          })     
        end

        it "returns proper json response of the last data of expense_reports" do
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
