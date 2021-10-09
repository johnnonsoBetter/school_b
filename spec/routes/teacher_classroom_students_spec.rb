require 'rails_helper'

RSpec.describe "TeacherClassroomStudents", type: :routing do
    describe "GET /index" do
        it "routes api/v1/teacher_classroom_students to apoi/v1/teacher_classroom_students#index" do
        expect(get 'api/v1/teacher_classroom_students').to route_to('api/v1/teacher_classroom_students#index')  
        
        end
        
       
    end
    
end
