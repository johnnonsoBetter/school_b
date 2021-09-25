require 'rails_helper'

RSpec.describe ScoreReport, type: :model do

  it { should belong_to(:teacher) } 
  it { should belong_to(:subject) } 
  it { should belong_to(:student) } 
  it { should belong_to(:score_type) }
end
