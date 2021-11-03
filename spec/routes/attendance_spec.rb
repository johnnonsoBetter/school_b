require 'rails_helper'


RSpec.describe Attendance, type: :routing do
    describe "PUT" do
        it "routes api/v1/attendances to api/v1/attendances#update" do
           expect(put 'api/v1/attendances/3').to    route_to( :controller => 'api/v1/attendances', :action => 'update', id: "3")  
           
        end
        
    end
    
end