require 'rails_helper'


RSpec.describe Teacher, type: :model do
    it { should belong_to(:school) } 
    it { should have_many(:classrooms).through(:subjects) } 
    it { should have_many(:score_reports) } 
    it { should have_many(:behaviour_reports) } 
    it { should have_many(:score_report_drafts) } 
end
