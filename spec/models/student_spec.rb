
  require 'rails_helper'


RSpec.describe Student, type: :model do
    it { should belong_to(:school) } 
    
    it { should have_many(:score_reports) } 
    it { should have_many(:behaviour_reports) } 
end
