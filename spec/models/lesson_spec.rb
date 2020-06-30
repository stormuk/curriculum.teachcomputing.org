require 'rails_helper'
require Rails.root.join 'spec/models/concerns/publishable_shared_examples.rb'
require Rails.root.join 'spec/models/concerns/rateable_shared_examples.rb'

RSpec.describe Lesson, type: :model do
  it_behaves_like 'publishable'
  it_behaves_like 'rateable'

  describe 'associations' do
    it { is_expected.to belong_to(:unit) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
