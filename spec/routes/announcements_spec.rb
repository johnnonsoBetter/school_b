require 'rails_helper'


RSpec.describe "Announcements", type: :routing do
    describe "POST" do
        it "routes api/v1/announcements to api/v1/announcements#create" do
           expect(post 'api/v1/announcements').to    route_to( :controller => 'api/v1/announcements', :action => 'create')  
           
        end
        
    end

    describe "PUT" do
        it "routes api/v1/announcements/3 to api/v1/announcements#update" do
           expect(put 'api/v1/announcements/3').to    route_to( :controller => 'api/v1/announcements', :action => 'update', id: "3")  
           
        end
        
    end


    describe "GET" do
        it "routes api/v1/announcements to api/v1/announcements#index" do
           expect(get 'api/v1/announcements').to    route_to( :controller => 'api/v1/announcements', :action => 'index')  
           
        end
        
    end

    describe "DELETE" do
        it "routes api/v1/announcements/3 to api/v1/announcements#destroy" do
           expect(delete 'api/v1/announcements/3').to    route_to( :controller => 'api/v1/announcements', :action => 'destroy', id: "3")  
           
        end
        
    end



    
end