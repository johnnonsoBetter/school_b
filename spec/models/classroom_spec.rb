require 'rails_helper'

RSpec.describe Classroom, type: :model do
  it { should validate_presence_of(:name) }
  it { should belong_to(:school) } 
  it { should have_many(:teachers).through(:subjects) }
  it { should have_many(:students) }
  it { should have_many(:attendances) }
  
end
