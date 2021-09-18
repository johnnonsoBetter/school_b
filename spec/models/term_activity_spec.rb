require 'rails_helper'

RSpec.describe TermActivity, type: :model do
  it { should belong_to(:student) } 
  it { should validate_presence_of(:term) }
end


