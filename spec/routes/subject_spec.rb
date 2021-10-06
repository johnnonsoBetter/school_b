require 'rails_helper'


RSpec.describe Subject, type: :routing do
    describe "POST" do
        it "routes api/v1/subjects to api/v1/subjects#create" do
           expect(post 'api/v1/subjects').to    route_to( :controller => 'api/v1/subjects', :action => 'create')  
           
        end
        
    end

    describe "GET" do
        it "routes api/v1/subjects to api/v1/subjects#index" do
           expect(get 'api/v1/subjects').to    route_to( :controller => 'api/v1/subjects', :action => 'index')  
           
        end
        
    end

    describe "GET" do
        it "routes api/v1/subjects/1 to api/v1/subjects#show" do
           expect(get 'api/v1/subjects/1').to    route_to( :controller => 'api/v1/subjects', :action => 'show', id: "1")  
           
        end
        
    end

    
end