require 'rails_helper'

RSpec.describe School, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:admins) } 
  it { should have_many(:students) } 
  it { should have_many(:teachers) } 
  it { should have_many(:classrooms) } 
  it { should have_many(:score_types) }
  it { should have_many(:bill_reports) } 
  it { should have_many(:items) } 
  it { should have_many(:restock_reports) }
  it { should have_many(:stock_repair_reports) }  
end
