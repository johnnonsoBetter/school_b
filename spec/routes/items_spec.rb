require 'rails_helper'

RSpec.describe Item, type: :routing do
    describe "POST" do
        it "routes api/v1/items to api/v1/items#create" do
           expect(post 'api/v1/items').to    route_to( :controller => 'api/v1/items', :action => 'create')  
           
        end
        
    end

end
