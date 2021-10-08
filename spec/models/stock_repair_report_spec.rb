require 'rails_helper'

RSpec.describe StockRepairReport, type: :model do
  it { should validate_presence_of(:quantity) }
  it { should validate_numericality_of(:quantity).is_greater_than(0) }
  it { should belong_to(:school) }
  it { should belong_to(:item) }  
end
