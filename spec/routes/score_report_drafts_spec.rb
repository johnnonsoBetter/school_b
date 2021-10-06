require 'rails_helper'


RSpec.describe ScoreReportDraft, type: :routing do
    describe "POST" do
        it "routes api/v1/score_report_drafts to api/v1/score_report_drafts#create" do
           expect(post 'api/v1/score_report_drafts').to    route_to( :controller => 'api/v1/score_report_drafts', :action => 'create')  
           
        end
        
    end

    describe "GET" do
        it "routes api/v1/score_report_drafts to api/v1/score_report_drafts#index" do
           expect(get 'api/v1/score_report_drafts').to    route_to( :controller => 'api/v1/score_report_drafts', :action => 'index')  
           
        end
        
    end

    describe "GET" do
        it "routes api/v1/score_report_drafts/1 to api/v1/score_report_drafts#show" do
           expect(get 'api/v1/score_report_drafts/1').to    route_to( :controller => 'api/v1/score_report_drafts', :action => 'show', id: "1")  
           
        end
        
    end

    
end