require 'rails_helper'

RSpec.describe PaymentHistory, type: :model do
  it { should validate_numericality_of(:amount).is_greater_than(0) }
  it { should belong_to(:bill) } 
end
