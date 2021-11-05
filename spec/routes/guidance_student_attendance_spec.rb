require 'rails_helper'



RSpec.describe "GuidanceStudentAttendance", type: :routing do
   

    describe "GET" do
        it "routes api/v1/guidance_student_attendances to api/v1/guidance_student_attendances#index" do
           expect(get 'api/v1/guidance_student_attendances').to    route_to( :controller => 'api/v1/guidance_student_attendances', :action => 'index')  
           
        end
        
    end

  
end