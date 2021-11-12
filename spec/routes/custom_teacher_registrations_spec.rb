require 'rails_helper'

RSpec.describe "CustomTeacherRegistrations", type: :routing do
    
   

    describe "POST" do
        it "routes api/v1/teacher_auth to api/v1/teacher_auth#create" do
           expect(post 'api/v1/teacher_auth').to    route_to( :controller => 'api/v1/custom_teacher_registrations', :action => 'create')  
           
        end
    
    end


    
end
