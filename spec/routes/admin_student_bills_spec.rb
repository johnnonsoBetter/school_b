require 'rails_helper'



RSpec.describe "AdminStudentBills", type: :routing do
   

    describe "GET" do
        it "routes api/v1/admin_student_bills to api/v1/admin_student_bills#index" do
           expect(get 'api/v1/admin_student_bills').to    route_to( :controller => 'api/v1/admin_student_bills', :action => 'index')  
           
        end
        
    end

  
end