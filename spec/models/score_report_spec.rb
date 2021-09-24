require 'rails_helper'

RSpec.describe ScoreReport, type: :model do
  it { should belong_to(:term_activity) } 
  it { should belong_to(:teacher) } 
end
