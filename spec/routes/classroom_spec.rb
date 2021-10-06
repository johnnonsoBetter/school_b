require 'rails_helper'


RSpec.describe Classroom, type: :routing do
    describe "POST" do
        it "routes api/v1/classrooms to api/v1/classrooms#create" do
           expect(post 'api/v1/classrooms').to    route_to( :controller => 'api/v1/classrooms', :action => 'create')  
           
        end
        
    end

    describe "GET" do
        it "routes api/v1/classrooms to api/v1/classrooms#index" do
           expect(get 'api/v1/classrooms').to    route_to( :controller => 'api/v1/classrooms', :action => 'index')  
           
        end
        
    end

    describe "GET" do
        it "routes api/v1/classrooms/1 to api/v1/classrooms#show" do
           expect(get 'api/v1/classrooms/1').to    route_to( :controller => 'api/v1/classrooms', :action => 'show', id: "1")  
           
        end
        
    end

    
end