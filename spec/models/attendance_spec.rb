require 'rails_helper'

RSpec.describe Attendance, type: :model do
 it { should belong_to(:classroom) } 
 it { should belong_to(:student) }
   
end
