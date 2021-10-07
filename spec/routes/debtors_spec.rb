require 'rails_helper'


RSpec.describe "Debtors", type: :routing do

    describe "GET" do
        it "routes api/v1/debtors to api/v1/debtors#index" do
           expect(get 'api/v1/debtors').to    route_to( :controller => 'api/v1/debtors', :action => 'index')  
           
        end
        
    end
    
end
