require 'rails_helper'



RSpec.describe "AdminStudentScoreReport", type: :routing do
   

    describe "GET" do
        it "routes api/v1/admin_student_score_reports to api/v1/admin_student_score_reports#index" do
           expect(get 'api/v1/admin_student_score_reports').to    route_to( :controller => 'api/v1/admin_student_score_reports', :action => 'index')  
           
        end
        
    end

  
end