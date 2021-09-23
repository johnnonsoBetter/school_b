require 'rails_helper'

RSpec.describe Student, type: :model  do
    it { should belong_to(:school) } 
    it { should have_many(:term_activities) } 
    it { should have_and_belong_to_many(:guidances) }
    it { should have_many(:bills) } 
end
