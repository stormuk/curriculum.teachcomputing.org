require 'rails_helper'

RSpec.describe Rating, type: :model do
  it { is_expected.to belong_to(:aggregate_rating) }
end
