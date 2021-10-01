require 'rails_helper'

RSpec.describe ScoreReportDraft, type: :model do
  it { should belong_to(:teacher) } 
  it { should belong_to(:subject) }
  it { should belong_to(:score_type) }  
  it { should have_many(:student_score_report_drafts) } 


end
