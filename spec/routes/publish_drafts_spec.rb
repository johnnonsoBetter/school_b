require 'rails_helper'

RSpec.describe "PublishDrafts", type: :routing do

    describe "POST /create" do
        it "routes api/v1/publish_drafts to api/v1/publish_drafts#create" do

            expect(post 'api/v1/publish_drafts').to  route_to('api/v1/publish_drafts#create')
            
        end
        
    end
    
    
end
