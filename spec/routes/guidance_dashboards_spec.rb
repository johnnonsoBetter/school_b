require 'rails_helper'

RSpec.describe "GuidanceDashboards", type: :routing do
    describe "guidance_dashboards routes" do
        it "routes api/v1/guidance_dashboards to api/v1/guidance_dashboards#index" do
            expect(get 'api/v1/guidance_dashboards').to route_to('api/v1/guidance_dashboards#index')  
        end
        
    end
    
end
