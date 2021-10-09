require 'rails_helper'

RSpec.describe ItemSold, type: :model do
  
  describe "#validations" do

    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
    it { should validate_presence_of(:total) }
    it { should validate_numericality_of(:total).is_greater_than(0) }
    it { should belong_to(:sale_report) }
    it { should belong_to(:item) }  

    let(:school){build :school}
    let(:admin){build :admin, school: school}
    let(:item){create :item, school: school, selling_price: 200 }
    let(:sale_report){build :sale_report, school: school, admin: admin}
    let(:item_sold){create :item_sold, sale_report: sale_report, quantity: 3, item: item}

    it "total should be 600" do

      the_item_sold = ItemSold.find(item_sold.id)
      expect(the_item_sold.total).to eq(600)  
      
    end
    

    
  end
  
end
