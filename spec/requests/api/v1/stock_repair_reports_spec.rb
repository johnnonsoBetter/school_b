

require 'rails_helper'

RSpec.describe "Api::V1::StockRepairReports", type: :request do
  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      create :item, id: 1, name: "js1 school book", selling_price: 600, school: sch, quantity: 4

      @stock_repair_report_params = {stock_repair_report: {quantity: 5, item_id: 1 }}

      @login_url = '/api/v1/auth/sign_in'
      @stock_repair_report_url = '/api/v1/stock_repair_reports'
  
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
        
        post @stock_repair_report_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  post @stock_repair_report_url, headers: @headers, params: @stock_repair_report_params } 

      context "when new stock_repair_report report has been created" do
        it "increment stock_repair_report report by 1" do
          expect{subject}.to change{StockRepairReport.count}.by(1)
        end

        it "update the item quantity to 5" do
          subject
          expect(Item.find(1).quantity).to eq(5)  
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
      

      context "when new stock_repair_report failed to be created" do


          it "do not increment stock_repair_report report " do
            expect{post @stock_repair_report_url, headers: @headers, params: {stock_repair_report: {quantity: 0, item_id: 1 }} }.to_not change{StockRepairReport.count}
          end

          it "returns htpp status code unprocessable entity" do
            post @stock_repair_report_url, headers: @headers, params: {stock_repair_report: {quantity: 0, item_id: 1}}
            expect(response).to have_http_status(:unprocessable_entity)
            
          end

 
       end

    end
    

  end






  describe "GET /index" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
  
      item = create :item, name: "js1 school book", selling_price: 600, school: sch
      term_date = create :term_date, id: 1, name: "1st term 2021/2021", start_date: Date.new(2021, 9, 4), end_date: Date.new(2021, 10, 11)

      create :stock_repair_report, school: sch, admin: @admin, quantity: 4, item: item, created_at: Date.new(2020, 10, 4)
      create :stock_repair_report, school: sch, admin: @admin, quantity: 7, item: item, created_at: Date.new(2021, 9, 4)

      create :stock_repair_report, school: sch, admin: @admin, quantity: 36, item: item, created_at: Date.new(2021, 10, 8)

      create :stock_repair_report, school: sch, admin: @admin, quantity: 15, item: item, created_at: Date.new(2021, 10, 11)

      create :stock_repair_report, school: sch, admin: @admin, quantity: 10, item: item, created_at: Time.now

      create :stock_repair_report, school: sch, admin: @admin, quantity: 31, item: item, created_at: Time.now
      
      
      
     

      @login_url = '/api/v1/auth/sign_in'
      @stock_repair_report_url = '/api/v1/stock_repair_reports/'
  
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
        
        get @stock_repair_report_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  get @stock_repair_report_url, headers: @headers } 

      context "when term_id params exists" do
        subject {  get @stock_repair_report_url, headers: @headers, params: {term_id: 1} } 

        before do 

          subject
          @json_body = JSON.parse(response.body)


        end

        it "returns proper json response of the first data of stock_repair_reports" do
          expect(@json_body.first).to include({
            'quantity' => 7
            
          })     
        end

        it "returns proper json response of the last data of stock_repair_reports" do
          expect(@json_body.last).to include({
            'quantity' => 15
            
          })     
        end
        
        
      end

      context "when date params exists" do
        subject {  get @stock_repair_report_url, headers: @headers, params: {date: Time.now} } 

        before do 

          subject
          @json_body = JSON.parse(response.body)


        end

        it "returns proper json response of the first data of stock_repair_reports" do
          expect(@json_body.first).to include({
            'quantity' => 10
            
          })     
        end

        it "returns proper json response of the last data of stock_repair_reports" do
          expect(@json_body.last).to include({
            'quantity' => 31
            
          })     
        end
        
        
      end

      context "when range params exists" do
        subject {  get @stock_repair_report_url, headers: @headers, params: {date_range: {from: Date.new(2021, 10, 8), to: Time.now}} } 

        before do 

          subject
          @json_body = JSON.parse(response.body)


        end

        it "returns proper json response of the first data of stock_repair_reports" do
          expect(@json_body.first).to include({
            'quantity' => 36
            
          })     
        end

        it "returns proper json response of the last data of stock_repair_reports" do
          expect(@json_body.last).to include({
            'quantity' => 31
            
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
