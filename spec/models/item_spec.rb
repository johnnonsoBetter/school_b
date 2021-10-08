require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:selling_price) }
  it { should validate_numericality_of(:selling_price).is_greater_than(0) }
end
