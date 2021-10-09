require 'rails_helper'

RSpec.describe StockRepairReport, type: :routing do
    
    describe "POST" do
        it "routes api/v1/stock_repair_reports to api/v1/stock_repair_reports#create" do
           expect(post 'api/v1/stock_repair_reports').to    route_to( :controller => 'api/v1/stock_repair_reports', :action => 'create')  
           
        end
    
    end

    
end
