require 'rails_helper'


RSpec.describe Guidance, type: :model do
    it { should have_and_belong_to_many(:students) }
     
end
