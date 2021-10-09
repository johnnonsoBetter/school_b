require 'rails_helper'

RSpec.describe DebtRecoveredReport, type: :routing do
    
    describe "POST" do
        it "routes api/v1/debt_recovered_reports to api/v1/debt_recovered_reports#create" do
           expect(post 'api/v1/debt_recovered_reports').to    route_to( :controller => 'api/v1/debt_recovered_reports', :action => 'create')  
           
        end
    
    end

    
end
