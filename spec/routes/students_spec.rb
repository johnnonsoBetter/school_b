require 'rails_helper'

RSpec.describe "Students", type: :routing do
    
   

    describe "GET" do
        it "routes api/v1/students to api/v1/students#index" do
           expect(get 'api/v1/students').to    route_to( :controller => 'api/v1/students', :action => 'index')  
           
        end
    
    end

    describe "GET" do
        it "routes api/v1/students to api/v1/students#show" do
           expect(get 'api/v1/students/3').to    route_to( :controller => 'api/v1/students', :action => 'show',  id: "3")  
           
        end
    
    end

    
end
