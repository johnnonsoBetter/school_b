require 'rails_helper'

RSpec.describe SaleReport, type: :model do
  it { should validate_presence_of(:total) }
  it { should validate_numericality_of(:total).is_greater_than(0) }
  it { should belong_to(:admin) }
  it { should belong_to(:school) }
  it { should have_many(:item_solds) } 
 
end
