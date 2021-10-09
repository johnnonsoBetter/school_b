require 'rails_helper'

RSpec.describe SaleReport, type: :routing do
    
    describe "POST" do
        it "routes api/v1/sale_reports to api/v1/sale_reports#create" do
           expect(post 'api/v1/sale_reports').to    route_to( :controller => 'api/v1/sale_reports', :action => 'create')  
           
        end
    
    end

    
end