require 'rails_helper'

RSpec.describe Bill, type: :model do
  it { should belong_to(:student) } 
  it { should validate_presence_of(:title) }
  it { should validate_numericality_of(:total_amount).is_greater_than(0) }
  it { should have_many(:payment_histories) } 
end
