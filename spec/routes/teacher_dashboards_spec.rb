require 'rails_helper'

RSpec.describe "TeacherDashboards", type: :routing do
    describe "GET /index" do
        it "routes api/v1/teacher_dashboards to apoi/v1/teacher_dashboards#index" do
        expect(get 'api/v1/teacher_dashboards').to route_to('api/v1/teacher_dashboards#index')  
        
        end
        
       
    end
    
end
