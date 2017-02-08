require 'rails_helper'

RSpec.describe Category do
  context 'validations' do
    it { should validate_presence_of(:name) }
        
    it "should validate uniquess of name case-insensitively" do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:category, name: "Important", user: user)
      category2 = FactoryGirl.build(:category, name: "important", user: user)
      
      expect(category2).not_to be_valid
    end
  end
end