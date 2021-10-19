

require 'rails_helper'

RSpec.describe "Api::V1::SaleReports", type: :request do
  describe "POST /create" do
   
    before do 
      sch = build :school, id: 44
      @admin = create :admin, email: "admin@mail.com", password: "password", school: sch, permitted: true
      create :item, id: 1, name: "js1 school book", selling_price: 600, school: sch, quantity: 4
      create :item, id: 2, name: "js2 book", selling_price: 600, school: sch, quantity: 4


      @sale_report_params = {sale_report: {total: 2400}, items_sold: [{item_id: 1, quantity: 3}, {item_id: 2, quantity: 1}]}

      @login_url = '/api/v1/auth/sign_in'
      @sale_report_url = '/api/v1/sale_reports'
  
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
        
        post @sale_report_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  post @sale_report_url, headers: @headers, params: @sale_report_params } 

      context "when new sale_report report has been created" do
        it "increment sale_report report by 1" do
          expect{subject}.to change{SaleReport.count}.by(1)
        end

        it "increment itemsolds count by 2" do
          expect{subject}.to change{ItemSold.count}.by(2) 
        end
        

        it "decrement the first item quantity to 1" do
          subject
          expect(Item.find(1).quantity).to eq(1)  
        end

        it "decrement the first item quantity to 1" do
          subject
          expect(Item.find(2).quantity).to eq(3)  
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

      context "when the total sent from the client is quite different from that of the calculated in the backend" do


        
        it "returns http status unprocessable entity" do
          post @sale_report_url, headers: @headers, params: {sale_report: {total: 200}, items_sold: [{item_id: 1, quantity: 3}, {item_id: 2, quantity: 1}]}
        expect(response).to have_http_status(:unprocessable_entity)  

          
        end
        
        
      end



      

      context "when new sale_report failed to be created" do


          it "do not increment sale_report report " do
            expect{  post @sale_report_url, headers: @headers, params: {sale_report: {total: 2400}, items_sold: [{item_id: 5, quantity: 3}, {item_id: 2, quantity: 1}]} }.to_not change{StockRepairReport.count}
          end

          it "returns htpp status code unprocessable entity" do
            post @sale_report_url, headers: @headers, params: {sale_report: {total: 2400}, items_sold: [{item_id: 1, quantity: 0}, {item_id: 2, quantity: 1}]}
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

      create :sale_report, school: sch, admin: @admin, total: 100, created_at: Date.new(2020, 10, 4)
      create :sale_report, school: sch, admin: @admin, total: 300, created_at: Date.new(2021, 9, 4)

      create :sale_report, school: sch, admin: @admin, total: 600, created_at: Date.new(2021, 10, 8)

      create :sale_report, school: sch, admin: @admin, total: 950, created_at: Date.new(2021, 10, 11)

      create :sale_report, school: sch, admin: @admin, total: 110, created_at: Time.now

      create :sale_report, school: sch, admin: @admin, total: 450, created_at: Time.now
      
      
      
     

      @login_url = '/api/v1/auth/sign_in'
      @sale_report_url = '/api/v1/sale_reports/'
  
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
        
        get @sale_report_url
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when admin is authenticated " do

      subject {  get @sale_report_url, headers: @headers } 

      context "when term_id params exists" do
        subject {  get @sale_report_url, headers: @headers, params: {term_id: 1} } 

        before do 

          subject
          @json_body = JSON.parse(response.body)


        end

     
        

        it "returns proper json response of the first data of sale_reports" do
          expect(@json_body.first).to include({
            'total' => 300
            
          })     
        end

        it "returns proper json response of the last data of sale_reports" do
          expect(@json_body.last).to include({
            'total' => 950
            
          })     
        end
        
        
      end

      context "when date params exists" do
        subject {  get @sale_report_url, headers: @headers, params: {date: Time.now} } 

        before do 

          subject
          @json_body = JSON.parse(response.body)


        end

        it "returns proper json response of the first data of sale_reports" do
          expect(@json_body.first).to include({
            'total' => 110
            
          })     
        end

        it "returns proper json response of the last data of sale_reports" do
          expect(@json_body.last).to include({
            'total' => 450
            
          })     
        end
        
        
      end

      context "when range params exists" do
        subject {  get @sale_report_url, headers: @headers, params: {from: Date.new(2021, 10, 8), to: Date.new(2021, 10, 11)} } 

        before do 

          subject
          @json_body = JSON.parse(response.body)


        end

        it "returns proper json response of the first data of sale_reports" do
          expect(@json_body.first).to include({
            'total' => 600
            
          })     
        end

        it "returns proper json response of the last data of sale_reports" do
          expect(@json_body.last).to include({
            'total' => 950
            
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
