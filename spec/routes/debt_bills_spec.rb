require 'rails_helper'

RSpec.describe "DebtBills", type: :routing do
    
   

    describe "GET" do
        it "routes api/v1/debt_bills to api/v1/debt_bills#index" do
           expect(get 'api/v1/debt_bills').to    route_to( :controller => 'api/v1/debt_bills', :action => 'index')  
           
        end
    
    end

    
end
