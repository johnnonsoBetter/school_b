require 'rails_helper'

RSpec.describe Bill, type: :model do
  it { should belong_to(:student) } 
  it { should belong_to(:bill_report) } 
  it { should have_many(:payment_histories) } 
end
