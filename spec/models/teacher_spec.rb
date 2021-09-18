require 'rails_helper'


RSpec.describe Teacher, type: :model do
    it { should belong_to(:school) } 
    it { should have_many(:classrooms).through(:subjects) } 
end
