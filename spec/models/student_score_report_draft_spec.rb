require 'rails_helper'

RSpec.describe StudentScoreReportDraft, type: :model do
  it { should belong_to(:student) }
  it { should belong_to(:score_report_draft) }  
end
