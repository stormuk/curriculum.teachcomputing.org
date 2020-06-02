require 'rails_helper'

RSpec.describe KeyStage, type: :model do
  let(:key_stage_one) { create(:key_stage) }

  describe 'associations' do
    it 'has_many year_groups' do
      expect(key_stage_one).to have_many(:year_groups)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
