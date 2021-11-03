
  require 'rails_helper'


RSpec.describe Student, type: :model do

    it { should belong_to(:school) } 
    it { should belong_to(:classroom) } 
    it { should have_many(:score_reports) } 
    it { should have_many(:behaviour_reports) } 
    it { should have_many(:attendances) }
    # it { should validate_presence_of(:first_name) }
    # it { should validate_presence_of(:last_name) }
    # it { should validate_presence_of(:middle_name) }
    # it { should validate_presence_of(:date_of_birth) }
    # it { should validate_presence_of(:date_of_admission) }
    # it { should validate_presence_of(:state) }
    # it { should validate_presence_of(:lga) }
    # it { should validate_presence_of(:religion) }
    # it { should validate_presence_of(:address) }
    # it { should validate_presence_of(:image) }
    
    
    
    
end
