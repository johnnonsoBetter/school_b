require 'rails_helper'

RSpec.describe Subject, type: :model do
  it { should validate_presence_of(:name) }
  it { should belong_to(:classroom) } 
  it { should belong_to(:teacher) } 
  
end
