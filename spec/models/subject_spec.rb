require 'rails_helper'

RSpec.describe Subject, type: :model do
  it { should belong_to(:classroom) } 
  it { should belong_to(:teacher) } 
end
