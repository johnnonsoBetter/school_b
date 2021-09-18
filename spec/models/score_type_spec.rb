require 'rails_helper'

RSpec.describe ScoreType, type: :model do
  it { should belong_to(:school) }
  it { should validate_presence_of(:name) } 
end
