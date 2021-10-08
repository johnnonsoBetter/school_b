require 'rails_helper'

RSpec.describe Item, type: :routing do
    describe "POST" do
        it "routes api/v1/items to api/v1/items#create" do
           expect(post 'api/v1/items').to    route_to( :controller => 'api/v1/items', :action => 'create')  
           
        end
        
        it "routes api/v1/items/1 to api/v1/items#update" do
            expect(put 'api/v1/items/1').to    route_to( :controller => 'api/v1/items', :action => 'update', id: "1")  
        
        end

        it "routes api/v1/items/1 to api/v1/items#delete" do
            expect(delete 'api/v1/items/1').to    route_to( :controller => 'api/v1/items', :action => 'destroy', id: "1")  
        
        end
     
    end

end
