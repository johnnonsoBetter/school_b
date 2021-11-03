require 'rails_helper'


RSpec.describe "MultipleAttendanceCreator", type: :routing do
    describe "POST" do
        it "routes api/v1/multiple_attendance_creators to api/v1/multiple_attendance_creators#create" do
           expect(post 'api/v1/multiple_attendance_creators').to    route_to( :controller => 'api/v1/multiple_attendance_creators', :action => 'create')  
           
        end
        
    end
    
end
