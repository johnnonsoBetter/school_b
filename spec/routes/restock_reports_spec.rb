require 'rails_helper'

RSpec.describe RestockReport, type: :routing do
    describe "POST" do
        it "routes api/v1/restock_reports to api/v1/restock_reports#create" do
           expect(post 'api/v1/restock_reports').to    route_to( :controller => 'api/v1/restock_reports', :action => 'create')  
           
        end
    
    end

    describe "GET" do
        it "routes api/v1/restock_reports to api/v1/restock_reports#index" do
           expect(get 'api/v1/restock_reports').to    route_to( :controller => 'api/v1/restock_reports', :action => 'index')  
           
        end
    
    end



end
