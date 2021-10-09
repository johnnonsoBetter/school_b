require 'rails_helper'

RSpec.describe ExpenseReport, type: :model do
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:title) }
  it { should validate_numericality_of(:amount).is_greater_than(0) }
  it { should belong_to(:admin) }
  it { should belong_to(:school) }  
end
