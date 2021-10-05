require 'rails_helper'

RSpec.describe "StudentScoreReportDrafts", type: :routing do

    describe "PUT" do
        it "routes api/v1/student_score_report_drafts/1 to api/v1/student_score_report_drafts#update" do
           expect(put 'api/v1/student_score_report_drafts/1').to    route_to( :controller => 'api/v1/student_score_report_drafts', :action => 'update', id: "1")  
           
        end
        
    end

    describe "GET" do
        it "routes api/v1/student_score_report_drafts to api/v1/student_score_report_drafts#index" do
           expect(get 'api/v1/student_score_report_drafts').to    route_to( :controller => 'api/v1/student_score_report_drafts', :action => 'index')  
           
        end
        
    end
    
end
