require 'rails_helper'

RSpec.describe BehaviourReport, type: :model do
 it { should validate_presence_of(:title) }
 it { should validate_presence_of(:description) }
 it { should validate_presence_of(:behaviour_type) }
end
