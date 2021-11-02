require 'rails_helper'

RSpec.describe "CustomStudents", type: :routing do
    
   

    describe "POST" do
        it "routes api/v1/student_auth to api/v1/student_auth#create" do
           expect(post 'api/v1/student_auth').to    route_to( :controller => 'api/v1/custom_student_registrations', :action => 'create')  
           
        end
    
    end

    describe "PUT" do
        it "routes api/v1/student_auth to api/v1/student_auth#update" do
           expect(put 'api/v1/student_auth/').to    route_to( :controller => 'api/v1/custom_student_registrations', :action => 'update')  
           
        end
    
    end

    
end
