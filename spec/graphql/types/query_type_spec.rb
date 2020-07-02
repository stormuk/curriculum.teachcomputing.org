require 'rails_helper'

RSpec.describe Types::QueryType do
  subject { described_class }

  it { is_expected.to have_field(:year_groups).of_type('[YearGroup!]!') }
  it { is_expected.to have_field(:key_stages).of_type('[KeyStage!]!') }
  it { is_expected.to have_field(:assessments).of_type('[Assessment!]!') }
  it { is_expected.to have_field(:lessons).of_type('[Lesson!]!') }
  it { is_expected.to have_field(:units).of_type('[Unit!]!') }

  describe 'year_group' do
    subject { described_class.fields['yearGroup'] }

    it { is_expected.to be_of_type('YearGroup!') }
    it { is_expected.to accept_argument(:id).of_type('ID!') }
  end

  describe 'key_stage' do
    subject { described_class.fields['keyStage'] }

    it { is_expected.to be_of_type('KeyStage!') }
    it { is_expected.to accept_argument(:id).of_type('ID!') }
  end

  describe 'assessment' do
    subject { described_class.fields['assessment'] }

    it { is_expected.to be_of_type('Assessment!') }
    it { is_expected.to accept_argument(:id).of_type('ID!') }
  end

  describe 'lesson' do
    subject { described_class.fields['lesson'] }

    it { is_expected.to be_of_type('Lesson!') }
    it { is_expected.to accept_argument(:id).of_type('ID!') }
  end

  describe 'unit' do
    subject { described_class.fields['unit'] }

    it { is_expected.to be_of_type('Unit!') }
    it { is_expected.to accept_argument(:id).of_type('ID!') }
  end
end