require 'rails_helper'

RSpec.describe BillReport, type: :model do
  it { should have_many(:bills) } 
  it { should validate_numericality_of(:amount).is_greater_than(0) }
end
