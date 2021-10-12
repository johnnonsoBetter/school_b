require 'rails_helper'

RSpec.describe "Students", type: :routing do
    
   

    describe "GET" do
        it "routes api/v1/teachers to api/v1/teachers#index" do
           expect(get 'api/v1/teachers').to    route_to( :controller => 'api/v1/teachers', :action => 'index')  
           
        end
    
    end

    
end
