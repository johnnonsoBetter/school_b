require 'rails_helper'


RSpec.describe AnnouncementImage, type: :routing do
   

    describe "GET" do
        it "routes api/v1/announcement_images to api/v1/announcement_images#index" do
           expect(get 'api/v1/announcement_images').to    route_to( :controller => 'api/v1/announcement_images', :action => 'index')  
           
        end
        
    end

    
end