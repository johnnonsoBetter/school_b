require 'rails_helper'


RSpec.describe BehaviourReport, type: :routing do
    describe "POST" do
        it "routes api/v1/teacher_behaviour_reports to api/v1/teacher_behaviour_reports#create" do
           expect(post 'api/v1/teacher_behaviour_reports').to    route_to( :controller => 'api/v1/teacher_behaviour_reports', :action => 'create')  
           
        end
        
    end

    describe "GET" do
        it "routes api/v1/teacher_behaviour_reports to api/v1/teacher_behaviour_reports#index" do
           expect(get 'api/v1/teacher_behaviour_reports').to    route_to( :controller => 'api/v1/teacher_behaviour_reports', :action => 'index')  
           
        end
        
    end
    
end
