require 'rails_helper'

require 'rails_helper'


RSpec.describe BillReport, type: :routing do
    describe "POST" do
        it "routes api/v1/bill_reports to api/v1/bill_reports#create" do
           expect(post 'api/v1/bill_reports').to    route_to( :controller => 'api/v1/bill_reports', :action => 'create')  
           
        end
        
    end

    describe "GET" do
        it "routes api/v1/bill_reports to api/v1/bill_reports#index" do
           expect(get 'api/v1/bill_reports').to    route_to( :controller => 'api/v1/bill_reports', :action => 'index')  
           
        end
        
    end

    # describe "GET" do
    #     it "routes api/v1/bill_reports/1 to api/v1/bill_reports#show" do
    #        expect(get 'api/v1/bill_reports/1').to    route_to( :controller => 'api/v1/bill_reports', :action => 'show', id: "1")  
           
    #     end
        
    # end

    
end