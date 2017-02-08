require 'rails_helper'

RSpec.describe User do
  context 'associations' do
    it { should have_many(:notes) }
    it { should have_many(:categories) }
  end
end