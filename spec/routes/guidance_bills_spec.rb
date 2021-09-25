require 'rails_helper'


RSpec.describe "GuidanceBills", type: :routing do
    describe "GET" do
        it "routes api/v1/guidance_bills to api/v1/guidance_bills#index" do
           expect(get 'api/v1/guidance_bills').to    route_to( :controller => 'api/v1/guidance_bills', :action => 'index')  
        end
        
    end
    
end
